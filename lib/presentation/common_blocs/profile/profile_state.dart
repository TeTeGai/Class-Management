
import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/user_model.dart';

class ProfileState extends Equatable{
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class LoadingProfile extends ProfileState{}

class LoadedProfile extends ProfileState{
  final UserModel loggedUser;
  LoadedProfile(this.loggedUser);
  @override
  List<Object?> get props => [this.loggedUser];
  @override
  String toString() {
    return "{ProfileLoaded: loggedUser:${this.loggedUser.toString()}}";
  }
}

class LoadedProfileById extends ProfileState{
  final UserModel loggedUser;
  LoadedProfileById(this.loggedUser);
  @override
  List<Object?> get props => [this.loggedUser];
  @override
  String toString() {
    return "{ProfileLoaded: loggedUser:${this.loggedUser.toString()}}";
  }
}

class LoadFailProfile extends ProfileState{
  final String error;
  LoadFailProfile(this.error);
  @override
  List<Object?> get props => [this.error];
}