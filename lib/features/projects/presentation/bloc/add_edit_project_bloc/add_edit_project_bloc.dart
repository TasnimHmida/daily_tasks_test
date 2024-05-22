import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/utils/pref_utils.dart';
import '../../../../manage_user/data/models/user_model.dart';
import '../../../../manage_user/domain/use_cases/get_all_users_usecase.dart';
import '../../../../notifications/domain/use_cases/create_new_notification_usecase.dart';
import '../../../data/models/project_model.dart';
import '../../../domain/use_cases/create_project_usecase.dart';
import '../../../domain/use_cases/update_project_usecase.dart';

part 'add_edit_project_event.dart';
part 'add_edit_project_state.dart';

class AddEditProjectBloc extends Bloc<AddEditProjectEvent, AddEditProjectState> {
  final CreateNewNotificationUseCase createNewNotificationUseCase;
  final CreateProjectUseCase createProjectUseCase;
  final UpdateProjectUseCase updateProjectUseCase;
  final GetAllUsersUseCase getAllUsersUseCase;
  final PrefUtils prefUtils;

  AddEditProjectBloc({
    required this.updateProjectUseCase,
    required this.createNewNotificationUseCase,
    required this.createProjectUseCase,
    required this.getAllUsersUseCase,
    required this.prefUtils,
  }) : super(const AddEditProjectState()) {
    on<CreateProjectEvent>(_onCreateProjectEvent);
    on<EditProjectEvent>(_onEditProjectEvent);
    on<GetUsersEvent>(_onGetUsersEvent);
  }

  Future<void> _onCreateProjectEvent(
      CreateProjectEvent event, Emitter<AddEditProjectState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', success: false));

    final failureOrDoneMessage = await createProjectUseCase(event.project);

    await failureOrDoneMessage.fold(
          (failure) async {
        emit(state.copyWith(
          error: _mapFailureToMessage(failure),
          isLoading: false,
        ));
      },
          (_) async {
        List<UserModel> users = event.project.members ?? [];
        for (UserModel user in users) {
          await createNewNotificationUseCase(
            user.userId ?? '',
            '${prefUtils.getUserInfo()?.userName} added you to a new project ${event.project.name}',
          );
        }
        emit(state.copyWith(
          success: true,
          error: '',
          isLoading: false,
        ));
      },
    );
  }

  Future<void> _onEditProjectEvent(
      EditProjectEvent event, Emitter<AddEditProjectState> emit) async {
    emit(state.copyWith(isLoading: true, error: '', success: false));

    final failureOrDoneMessage = await updateProjectUseCase(event.project);

    await failureOrDoneMessage.fold(
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

  Future<void> _onGetUsersEvent(
      GetUsersEvent event, Emitter<AddEditProjectState> emit) async {
    emit(state.copyWith(isLoadingGetUsers: true, error: '', success: false));

    final failureOrDoneMessage = await getAllUsersUseCase();

    await failureOrDoneMessage.fold(
          (failure) {
        emit(state.copyWith(
          error: _mapFailureToMessage(failure),
          isLoadingGetUsers: false,
        ));
      },
          (users) {
        emit(state.copyWith(
            error: '', isLoadingGetUsers: false, users: users));
      },
    );
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
