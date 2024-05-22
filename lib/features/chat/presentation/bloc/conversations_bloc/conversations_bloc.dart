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
        emit(state.copyWith(error: '', createConversationSuccess: false));

        final failureOrDoneMessage =
            await createConversationUseCase(event.userTwo);
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
        UserModel? loggedUser = prefUtils.getUserInfo();

        final failureOrDoneMessage = await getAllUsersUseCase();
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (users) {
            // Get the ID of the current user from SharedPreferences
            final currentUserID = prefUtils.getUserInfo()?.userId;

            // Extract the user IDs from the conversation models in the state
            final existingUserIDs = event.conversations
                ?.expand((conversation) => [conversation.contact?.userId]);

            print(' event.conversations:: ${event.conversations}');
            // Remove users that match the IDs of users in the conversation models
            final filteredUsers = users.where(
                (user) => !(existingUserIDs ?? []).contains(user.userId));

            // Remove the user with the same ID as the current user
            final filteredUsersExceptCurrentUser =
                filteredUsers.where((user) => user.userId != currentUserID);

            emit(state.copyWith(
                error: '',
                isLoading: false,
                users: filteredUsersExceptCurrentUser.toList()));
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
