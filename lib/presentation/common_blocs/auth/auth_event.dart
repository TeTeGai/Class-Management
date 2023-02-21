import 'package:equatable/equatable.dart';
class AuthEvent extends Equatable{
  const AuthEvent();

  @override
  List<Object> get props => [];
}
class AuthenticationStarted  extends AuthEvent{}

class LoggedIn extends AuthEvent{}

class LoggedOut extends AuthEvent{}
class UpdateAvatar extends AuthEvent{
  final String img;
  UpdateAvatar(this.img);
}