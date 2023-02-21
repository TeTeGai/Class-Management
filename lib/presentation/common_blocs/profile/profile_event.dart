
import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/user_model.dart';

class ProfileEvent extends Equatable{
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadProfile extends ProfileEvent {}

class LoadProfileById extends ProfileEvent {
  final String userId;
  const LoadProfileById(this.userId);
  @override
  // TODO: implement props
  List<Object?> get props => [userId];
}

class UploadAvatar extends Equatable{
  final String avatar;
  const UploadAvatar(this.avatar);

  @override
  List<Object> get props => [this.avatar];
}

class UpdateProfile extends ProfileEvent{
  final UserModel userModel;
  const UpdateProfile(this.userModel);
  @override
  List<Object> get props => [this.userModel];
}
class UpdateProfileById extends ProfileEvent{
  final UserModel userModel;
  const UpdateProfileById(this.userModel);
  @override
  List<Object> get props => [this.userModel];
}