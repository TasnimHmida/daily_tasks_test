part of 'add_edit_project_bloc.dart';

class AddEditProjectState extends Equatable {
  final bool isLoading;
  final bool isLoadingGetUsers;
  final String error;
  final bool success;
  final List<UserModel>? users;

  const AddEditProjectState(
      {this.isLoading = false,
      this.isLoadingGetUsers = false,
      this.error = "",
      this.success = false,
      this.users});

  AddEditProjectState copyWith({
    bool? isLoading,
    bool? isLoadingGetUsers,
    String? error,
    bool? success,
    List<UserModel>? users,
  }) {
    return AddEditProjectState(
      isLoading: isLoading ?? this.isLoading,
      isLoadingGetUsers: isLoadingGetUsers ?? this.isLoadingGetUsers,
      error: error ?? this.error,
      success: success ?? this.success,
      users: users ?? this.users,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
    isLoadingGetUsers,
        error,
        success,
        users,
      ];
}
