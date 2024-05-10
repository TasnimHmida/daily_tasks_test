import 'package:flutter_bloc/flutter_bloc.dart';
import '../../features/projects/data/models/project_model.dart';
import '../error/failures.dart';
import '../strings/failures.dart';
import 'package:equatable/equatable.dart';
import '../../features/projects/domain/use_cases/get_all_projects_usecase.dart';

part 'core_event.dart';

part 'core_state.dart';

class CoreBloc extends Bloc<CoreEvent, CoreState> {
  final GetAllProjectsUseCase getAllProjectsUseCase;

  CoreBloc({
    required this.getAllProjectsUseCase,
  }) : super(const CoreState()) {
    on<CoreEvent>((event, emit) async {
      if (event is GetAllProjectsEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage =
        await getAllProjectsUseCase();
        print('projects::: ${failureOrDoneMessage}');

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
