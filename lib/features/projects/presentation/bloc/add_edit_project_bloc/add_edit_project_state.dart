part of 'add_edit_project_bloc.dart';

class AddEditProjectState extends Equatable {
  final bool isLoading;
  final String error;
  final bool success;

  const AddEditProjectState({
    this.isLoading = false,
    this.error = "",
    this.success = false,
  });

  AddEditProjectState copyWith({
    bool? isLoading,
    String? error,
    bool? success,
  }) {
    return AddEditProjectState(
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
