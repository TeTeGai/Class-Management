import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/model/user_model.dart';

abstract class AuthRepository{
  User get loggedFirebaseUser;
  String get authException;
  Future<void> signUp(UserModel userModel, String password);
  Future<void> logInWithEmail(String email,String password);
  Future<String> checkRole(String id);
  bool isLogged();
  Future<void> logOut();
  Future<void> updateUserPassword(String OldPassword,String Password, BuildContext contex);
  Future<void> updateUserAvatar( String  file);
}