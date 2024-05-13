import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../data/models/task_model.dart';
import '../../../domain/use_cases/create_project_usecase.dart';
import '../../../domain/use_cases/get_project_tasks_usecase.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final GetProjectTasksUseCase getProjectTasksUseCase;

  TasksBloc({
    required this.getProjectTasksUseCase,
  }) : super(const TasksState()) {
    on<TasksEvent>((event, emit) async {
      if (event is GetProjectTasksEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage =
            await getProjectTasksUseCase(event.projectId);
        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (tasks) {
            emit(state.copyWith(
                success: true, error: '', isLoading: false, tasks: tasks));
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
