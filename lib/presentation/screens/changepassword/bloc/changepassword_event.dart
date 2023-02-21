import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/model/user_model.dart';

abstract class ChangePassWordEvent extends Equatable
{
  const ChangePassWordEvent();
  @override
  List<Object> get props => [];

}

class OldPasswordChange  extends ChangePassWordEvent{
  final String OldPassword;
  const OldPasswordChange({required this.OldPassword});

  @override
  List<Object> get props => [OldPassword];

  @override
  String toString()
  {
    return 'PasswordChange{password: $OldPassword}';
  }
}

class NewPasswordChange  extends ChangePassWordEvent{
  final String NewPassword;
  const NewPasswordChange({required this.NewPassword});
  @override
  List<Object> get props => [NewPassword];
  @override
  String toString()
  {
    return 'PasswordChange{password: $NewPassword}';
  }
}

class ConfirmNewPasswordChange  extends ChangePassWordEvent{
  final String NewPassword;
  final String ConfirmNewPassword;
  const ConfirmNewPasswordChange({required this.NewPassword,required this.ConfirmNewPassword});
  @override
  List<Object> get props => [NewPassword,ConfirmNewPassword];
  @override
  String toString()
  {
    return 'PasswordChange{password: $ConfirmNewPassword}';
  }
}


class Submitted extends ChangePassWordEvent {// contains new user's information
  final String oldPassword;
  final String password;
  final String confirmPassword;
  final BuildContext contex;

  const Submitted({
    required this.oldPassword,
    required this.password,
    required this.confirmPassword,
    required this.contex,
  });
}