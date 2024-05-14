import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../data/models/project_model.dart';
import '../../../data/models/task_model.dart';
import '../../../domain/use_cases/add_task_usecase.dart';
import '../../../domain/use_cases/get_project_by_id_usecase.dart';
import '../../../domain/use_cases/get_project_tasks_usecase.dart';
import '../../../domain/use_cases/update_task_usecase.dart';

part 'project_details_event.dart';

part 'project_details_state.dart';

class ProjectDetailsBloc
    extends Bloc<ProjectDetailsEvent, ProjectDetailsState> {
  final GetProjectByIdUseCase getProjectByIdUseCase;
  final GetProjectTasksUseCase getProjectTasksUseCase;
  final AddTaskUseCase addTaskUseCase;
  final UpdateTaskUseCase updateTaskUseCase;

  ProjectDetailsBloc({
    required this.getProjectByIdUseCase,
    required this.getProjectTasksUseCase,
    required this.addTaskUseCase,
    required this.updateTaskUseCase,
  }) : super(const ProjectDetailsState()) {
    on<ProjectDetailsEvent>((event, emit) async {
      if (event is GetProjectByIdEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage =
            await getProjectByIdUseCase(event.projectId);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (project) {
            emit(state.copyWith(
                success: true, error: '', isLoading: false, project: project));
          },
        );
      }
      if (event is GetProjectTasksEvent) {
        emit(state.copyWith(isTasksLoading: true, error: '', success: false));

        final failureOrDoneMessage =
            await getProjectTasksUseCase(event.projectId);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isTasksLoading: false,
            ));
          },
          (tasks) {
            emit(state.copyWith(
                success: true, error: '', isTasksLoading: false, tasks: tasks));
          },
        );
      }

      if (event is AddTaskEvent) {
        emit(state.copyWith(error: '', success: false));

        final failureOrDoneMessage = await addTaskUseCase(event.task);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isTasksLoading: false,
            ));
          },
          (tasks) {
            emit(state.copyWith(
                success: true, error: '', isTasksLoading: false));
            add(GetProjectTasksEvent(
                projectId: event.task.projectId.toString()));
          },
        );
      }

      if (event is UpdateTaskEvent) {
        emit(state.copyWith(error: '', success: false));

        final failureOrDoneMessage = await updateTaskUseCase(event.task);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isTasksLoading: false,
            ));
          },
          (tasks) {
            emit(state.copyWith(
                success: true, error: '', isTasksLoading: false));
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
