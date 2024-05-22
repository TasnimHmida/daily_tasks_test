import 'dart:io';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../../../core/utils/pref_utils.dart';
import '../../../../manage_user/data/models/user_model.dart';
import '../../../domain/use_cases/update_user_usecase.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc
    extends Bloc<ProfileEvent, ProfileState> {
  final UpdateUserUseCase updateUserUseCase;
  final PrefUtils prefUtils;

  ProfileBloc({
    required this.updateUserUseCase,
    required this.prefUtils,
  }) : super(const ProfileState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is EditProfileEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));

        final failureOrDoneMessage = await updateUserUseCase(event.user, event.image);
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
            add(GetProfileInfoEvent());
          },
        );
      }
      if (event is GetProfileInfoEvent) {
        emit(state.copyWith(isLoading: true, error: '', success: false));
        emit(state.copyWith(isLoading: false, user: prefUtils.getUserInfo()));
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
