import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../data/models/project_model.dart';
import '../../../domain/use_cases/create_project_usecase.dart';
import '../../../domain/use_cases/update_project_usecase.dart';

part 'add_edit_project_event.dart';

part 'add_edit_project_state.dart';

class AddEditProjectBloc
    extends Bloc<AddEditProjectEvent, AddEditProjectState> {
  final CreateProjectUseCase createProjectUseCase;
  final UpdateProjectUseCase updateProjectUseCase;

  AddEditProjectBloc({
    required this.updateProjectUseCase,
    required this.createProjectUseCase,
  }) : super(const AddEditProjectState()) {
    on<AddEditProjectEvent>((event, emit) async {
      if (event is CreateProjectEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage = await createProjectUseCase(event.project);
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
      if (event is EditProjectEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage = await updateProjectUseCase(event.project);
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
