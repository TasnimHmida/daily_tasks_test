import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/use_cases/register_usecase.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({
    required this.registerUseCase,
  }) : super(const RegisterState()) {
    on<RegisterEvent>((event, emit) async {
      if (event is RegisterUserEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage =
            await registerUseCase(event.userName, event.email, event.password);
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
