import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable
{
  const LoginEvent();
  @override
  List<Object> get props => [];

}
class EmailChange  extends LoginEvent{
  final String email;
  const EmailChange({required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString()
  {
    return 'PasswordChange{password: $email}';
  }
}

class PasswordChange  extends LoginEvent{
  final String password;
  const PasswordChange({required this.password});

  @override
  List<Object> get props => [];

  @override
  String toString()
  {
    return 'PasswordChange{password: $password}';
  }
}

class LoginCredential  extends LoginEvent{
  final String password, email;
  const LoginCredential({required this.email,required this.password});

  @override
  List<Object> get props => [email,password];

}