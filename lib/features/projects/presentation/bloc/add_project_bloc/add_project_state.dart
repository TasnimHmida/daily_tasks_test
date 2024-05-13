part of 'add_project_bloc.dart';

class AddProjectState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;

  const AddProjectState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
  });

  AddProjectState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return AddProjectState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      success: success ?? this.success,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        error,
        success,
      ];
}
