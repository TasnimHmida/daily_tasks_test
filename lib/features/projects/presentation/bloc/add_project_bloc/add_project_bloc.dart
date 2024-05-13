import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../data/models/project_model.dart';
import '../../../domain/use_cases/create_project_usecase.dart';

part 'add_project_event.dart';

part 'add_project_state.dart';

class AddProjectBloc extends Bloc<AddProjectEvent, AddProjectState> {
  final CreateProjectUseCase createProjectUseCase;

  AddProjectBloc({
    required this.createProjectUseCase,
  }) : super(const AddProjectState()) {
    on<AddProjectEvent>((event, emit) async {
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
