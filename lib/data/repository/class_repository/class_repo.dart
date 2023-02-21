
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:luan_an/data/model/class_model.dart';

import '../../model/score_model.dart';

abstract class ClassRepository{
  User get loggedFirebaseUser;
  Future <void> createClass (ClassModel classModel, Uint8List file,String img);
  Future<void> joinClass(String classId,String userId);
  Future<void> AddInitScore(String classId);
  Future<void> AddInitGPA(String classId);
  Stream<List<ClassModel>>  loadClass (String uid);
  Future<void> deleteClass(String classId);
  Future<void> editClass(ClassModel classModel,Uint8List? file,String? img);
}