import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/data/repository/user_repository/user_repo.dart';

class UserAuthRepository extends userRepository
{
  var _usercollection =FirebaseFirestore.instance.collection("users");
  String _authException = "Authentication Failure";
  @override
  Future<void> addUser(UserModel newUser) async{

    await _usercollection.doc(newUser.id).set(newUser.toMap());
  }

  @override
  Future<UserModel> getUserByID(String id) async{
    return await _usercollection
        .doc(id)
        .get()
        .then((doc) => UserModel.fromMap(doc.data()!));
  }


  @override
  Stream<UserModel> getUser(String id) {
    return  _usercollection
        .doc(id)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data()!));
  }
  @override
  Stream<UserModel> loggedUserStream(User loggedFirebaseUser) {
    return _usercollection
        .doc(loggedFirebaseUser.uid)
        .snapshots()
        .map((doc) => UserModel.fromMap(doc.data()!));
  }

  @override
  Future<void> updateUserData(Map<String,String> dataUpdate) {
    return _usercollection.doc(FirebaseAuth.instance.currentUser?.uid).update(dataUpdate);
  }
  static final UserAuthRepository _instance =
  UserAuthRepository._internal();

  factory UserAuthRepository() {
    return _instance;
  }

  UserAuthRepository._internal();
}