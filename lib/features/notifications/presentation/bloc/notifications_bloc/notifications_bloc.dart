import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/utils/pref_utils.dart';
import '../../../../manage_user/data/models/user_model.dart';
import '../../../data/models/notification_model.dart';
import '../../../domain/use_cases/create_new_notification_usecase.dart';
import '../../../domain/use_cases/get_notifications_usecase.dart';

part 'notifications_event.dart';

part 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final CreateNewNotificationUseCase createNewNotificationUseCase;
  final GetNotificationsUseCase getNotificationsUseCase;
  final PrefUtils prefUtils;
  final SupabaseClient supabase;
  StreamSubscription? _messageSubscription;

  NotificationsBloc({
    required this.createNewNotificationUseCase,
    required this.getNotificationsUseCase,
    required this.prefUtils,
    required this.supabase,
  }) : super(const NotificationsState()) {
    on<NotificationsEvent>((event, emit) async {
      if (event is CreateNewNotificationEvent) {
        emit(state.copyWith(error: '', success: false));

        final failureOrDoneMessage =
            await createNewNotificationUseCase(event.userId, event.content);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
            ));
          },
          (_) {
            emit(state.copyWith(error: '', createConversationSuccess: true));
          },
        );
      }
      if (event is GetNotificationsEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage = await getNotificationsUseCase();
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (notifications) {
            emit(state.copyWith(
                success: true,
                error: '',
                isLoading: false,
                notifications: notifications));
          },
        );
      }
      supabase
          .channel('public:notifications')
          .onPostgresChanges(
              event: PostgresChangeEvent.all,
              schema: 'public',
              table: 'notifications',
              filter: PostgresChangeFilter(
                column: 'user_id',
                type: PostgresChangeFilterType.eq,
                value: prefUtils.getUserInfo()?.userId,
              ),
              callback: (payload) {
                add(GetNotificationsEvent());
              })
          .subscribe();
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return failure.message!;
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      default:
        return UNEXPECTED_FAILURE_MESSAGE;
    }
  }
}
