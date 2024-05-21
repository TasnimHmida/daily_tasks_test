import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/utils/pref_utils.dart';
import '../../../data/models/message_model.dart';
import '../../../domain/use_cases/get_messages_usecase.dart';
import '../../../domain/use_cases/send_message_usecase.dart';

part 'messages_event.dart';

part 'messages_state.dart';

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final SendMessageUseCase sendMessageUseCase;
  final GetMessagesUseCase getMessagesUseCase;
  final PrefUtils prefUtils;
  final SupabaseClient supabase;
  StreamSubscription? _messageSubscription;

  MessagesBloc({
    required this.sendMessageUseCase,
    required this.getMessagesUseCase,
    required this.prefUtils,
    required this.supabase,
  }) : super(const MessagesState()) {
    on<MessagesEvent>((event, emit) async {
      if (event is SendMessageEvent) {
        emit(state.copyWith(error: '', success: false));

        final failureOrDoneMessage = await sendMessageUseCase(
            event.messageContent, event.conversationId);

        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
            ));
          },
          (_) {
            emit(state.copyWith(
              success: true,
              error: '',
            ));
          },
        );
      }
      if (event is GetMessagesEvent) {
        emit(state.copyWith(
            isLoading: true,
            error: '',
            success: false,
            conversationId: event.conversationId));

        final failureOrDoneMessage =
            await getMessagesUseCase(event.conversationId);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (messages) {
            emit(state.copyWith(
                error: '',
                isLoading: false,
                success: true,
                messages: messages.reversed.toList()));
          },
        );
      }
      if (event is RefreshMessagesEvent) {
        emit(state.copyWith(error: '', isLoading: false, success: true));
        final failureOrDoneMessage =
            await getMessagesUseCase(event.conversationId);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
            ));
          },
          (messages) {
            emit(state.copyWith(error: '', success: false, messages: messages.reversed.toList()));
          },
        );
      }
    });

    supabase
        .channel('public:messages')
        .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'messages',
            callback: (payload) {
              add(RefreshMessagesEvent(conversationId: state.conversationId));
            })
        .subscribe();
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
