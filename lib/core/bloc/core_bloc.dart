import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/authentication/domain/use_cases/logout_usecase.dart';
import '../../features/manage_user/data/models/user_model.dart';
import '../../features/manage_user/domain/use_cases/get_user_info_usecase.dart';
import '../../features/projects/data/models/project_model.dart';
import '../error/failures.dart';
import '../strings/failures.dart';
import 'package:equatable/equatable.dart';
import '../../features/projects/domain/use_cases/get_all_projects_usecase.dart';

part 'core_event.dart';

part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  final GetAllProjectsUseCase getAllProjectsUseCase;
  final GetUserInfoUseCase getUserUseCase;
  final LogoutUseCase logoutUseCase;

  CoreBloc({
    required this.getAllProjectsUseCase,
    required this.logoutUseCase,
    required this.getUserUseCase,
  }) : super(const CoreState()) {
    on<CoreEvent>((event, emit) async {
      if (event is GetAllProjectsEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage = await getAllProjectsUseCase();

        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (projects) {
            emit(state.copyWith(
              success: true,
              error: '',
              isLoading: false,
              projects: projects,
            ));
          },
        );
      }
      if (event is LogoutEvent) {
        emit(
            state.copyWith(isLoading: true, error: '', isLogoutSuccess: false));

        final failureOrDoneMessage = await logoutUseCase();

        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (projects) {
            emit(state.copyWith(
              isLogoutSuccess: true,
              error: '',
              isLoading: false,
            ));
          },
        );
      }if (event is GetUserEvent) {
        emit(
            state.copyWith(isLoading: true, error: ''));

        final failureOrDoneMessage = await getUserUseCase();

        failureOrDoneMessage.fold(
          (failure) {
            emit(state.copyWith(
              error: _mapFailureToMessage(failure),
              isLoading: false,
            ));
          },
          (user) {
            emit(state.copyWith(
              error: '',
              isLoading: false,
              user: user
            ));
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
