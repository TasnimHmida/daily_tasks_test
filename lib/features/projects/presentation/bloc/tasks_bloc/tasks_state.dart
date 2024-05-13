part of 'tasks_bloc.dart';

class TasksState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;
  final List<TaskModel>? tasks;

  const TasksState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
    this.tasks,
  });

  TasksState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
    List<TaskModel>? tasks,
  }) {
    return TasksState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
      tasks: tasks ?? this.tasks,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
        tasks,
      ];
}
