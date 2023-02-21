
import 'package:firebase_auth/firebase_auth.dart';

import '../../model/user_model.dart';

abstract class userRepository{
  Stream<UserModel> loggedUserStream(User loggedFirebaseUser);
  Future<UserModel> getUserByID(String id);
  Stream<UserModel> getUser(String id);
  Future<void> addUser(UserModel newUser);
  Future<void> updateUserData(Map<String,String>  dataUpdate);

}