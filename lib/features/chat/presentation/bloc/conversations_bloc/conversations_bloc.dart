import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/utils/pref_utils.dart';
import '../../../../manage_user/data/models/user_model.dart';
import '../../../../manage_user/domain/use_cases/get_all_users_usecase.dart';
import '../../../data/models/conversation_model.dart';
import '../../../domain/use_cases/create_conversation_usecase.dart';
import '../../../domain/use_cases/get_conversations_usecase.dart';

part 'conversations_event.dart';

part 'conversations_state.dart';

class ConversationsBloc extends Bloc<ConversationEvent, ConversationsState> {
  final CreateConversationUseCase createConversationUseCase;
  final GetConversationsUseCase getConversationsUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final PrefUtils prefUtils;

  ConversationsBloc({
    required this.createConversationUseCase,
    required this.getConversationsUseCase,
    required this.getAllUsersUseCase,
    required this.prefUtils,
  }) : super(const ConversationsState()) {
    on<ConversationEvent>((event, emit) async {
      if (event is CreateConversationEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage =
            await createConversationUseCase(event.userTwo);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (_) {
            emit(state.copyWith(
              success: true,
              error: '',
              isLoading: false,
            ));
          },
        );
      }
      if (event is GetConversationsEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage = await getConversationsUseCase();
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (conversations) {
            emit(state.copyWith(
                success: true,
                error: '',
                isLoading: false,
                conversations: conversations));
          },
        );
      }
      if (event is CreateConversationUsersEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage = await getAllUsersUseCase();
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (users) {
            emit(state.copyWith(
                success: true,
                error: '',
                isLoading: false,
                users: users));
          },
        );
      }
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
