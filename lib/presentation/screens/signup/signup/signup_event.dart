import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/user_model.dart';

abstract class SignUpEvent extends Equatable
{
  const SignUpEvent();
  @override
  List<Object> get props => [];

}

class EmailChange  extends SignUpEvent{
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

class PhoneNumberChange  extends SignUpEvent{
  final String phoneNumber;
  const PhoneNumberChange({required this.phoneNumber});

  @override
  String toString()
  {
    return 'PasswordChange{password: $phoneNumber}';
  }
}

class FirstNameChange  extends SignUpEvent{
  final String firstName;
  const FirstNameChange({required this.firstName});

  @override
  String toString()
  {
    return 'PasswordChange{password: $firstName}';
  }
}

class LastNameChange  extends SignUpEvent{
  final String lastName;
  const LastNameChange({required this.lastName});

  @override
  String toString()
  {
    return 'PasswordChange{password: $lastName}';
  }
}

class PasswordChange  extends SignUpEvent{
  final String password;
  const PasswordChange({required this.password});

  @override
  String toString()
  {
    return 'PasswordChange{password: $password}';
  }
}

class ConfirmPasswordChange  extends SignUpEvent{
  final String password;
  final String confirmPassword;
  const ConfirmPasswordChange({required this.password,required this.confirmPassword});


  @override
  String toString()
  {
    return 'PasswordChange{password: $password, confirmpassword: $confirmPassword}';
  }
}

class Submitted extends SignUpEvent {
  final UserModel newUser; // contains new user's information
  final String password;
  final String confirmPassword;

  const Submitted({
    required this.newUser,
    required this.password,
    required this.confirmPassword,
  });
}