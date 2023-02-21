import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/repository/auth_repository/auth_repo.dart';
import 'package:luan_an/data/repository/user_repository/firebase_user_repo.dart';
import 'package:luan_an/utils/snackbar.dart';

import '../../model/user_model.dart';
import '../img_repository/firebase_img_repo.dart';

class FirebasaeAuthRepository implements AuthRepository {
  var _usercollection = FirebaseFirestore.instance.collection("users");
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserAuthRepository _userAuthRepository = UserAuthRepository();
  String _authException = "Authentication Failure";
  User get loggedFirebaseUser => _firebaseAuth.currentUser!;
  String get authException => _authException;

  @override
  bool isLogged() => _firebaseAuth.currentUser != null;


  @override
  Future<void> logInWithEmail(String email, String password) async {
    try
    {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut().catchError((error) {
      print(error);
    });
  }


  @override
  Future<void> signUp(UserModel newUser, String password) async{
    try
    {
      var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: newUser.email, password: password);
      newUser = newUser.cloneWith(id: userCredential.user?.uid);
      await _userAuthRepository.addUser(newUser);
    }  on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
//This code below is what your looking for
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

static final FirebasaeAuthRepository _instance = FirebasaeAuthRepository._internal();
  factory FirebasaeAuthRepository()
  {
    return _instance;
  }
  FirebasaeAuthRepository._internal();

  @override
  Future<String> checkRole(String id) async {
    late String role;
     await _usercollection.where("id",isEqualTo: id).get().then((querySnaphost)
    {
      var data = querySnaphost.docs[0].data();
      role = data["role"];
    });
    return role;
  }

  Future<void> updateUserPassword(String OldPassword,String Password, BuildContext context) async {
    try{
      User user = FirebaseAuth.instance.currentUser!;
      AuthCredential  cred =  EmailAuthProvider.credential(
          email: user.email.toString(), password: OldPassword);
      try {
        await  user.reauthenticateWithCredential(cred);
        user.updatePassword(Password).then((value) {
          Navigator.of(context).pop();
          MySnackBar.error(message: "Cập nhật mật khẩu thành công", color: Colors.cyan, context: context);
        });
      } on FirebaseAuthException catch (e) {
        MySnackBar.error(message: "Mật khẩu cũ không đúng", color: Colors.red, context: context);
      }
    }on FirebaseAuthException catch (e) {
      _authException = e.message.toString();
    }
  }

  @override
  Future<void> updateUserAvatar( String  file) async {
    _usercollection.doc(FirebaseAuth.instance.currentUser!.uid).update(
        {
          'avatar':file
        }
    );
  }
}
