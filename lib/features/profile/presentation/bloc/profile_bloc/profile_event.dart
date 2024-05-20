part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class EditProfileEvent extends ProfileEvent {
  final UserModel user;
  final File? image;

  EditProfileEvent({
    required this.user,
    required this.image,
  });

  @override
  List<Object> get props => [
        user,
      ];
}
class GetProfileInfoEvent extends ProfileEvent {}