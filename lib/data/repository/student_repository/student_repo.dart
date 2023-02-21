import 'dart:typed_data';

import 'package:luan_an/data/model/student_model.dart';

import '../../model/class_model.dart';
import '../../model/request_model.dart';

abstract class StudentRepository {
  Future<void> AddStudent(String nameText, String classId);

  Stream<List<StudentModel>> LoadStudent(String classId);

  Stream<List<StudentModel>> LoadStudentParent(String classId);

  Stream<List<StudentModel>> LoadStudentNoParent(String classId);

  Stream<List<StudentModel>> LoadSons(String userId);

  Future<void> AddSons(StudentModel studentModel,String userId,Uint8List? file,String? img);

  Future<void> AddParentStudent(String idParent,
      String classId, String studentId,);

  Future<void> ConnectSonToClass(String idParent,String sonId,String studentId,String classId);

  Future<void> AddRequest(String title,String content,String img,String userId,String studentId);
  Stream<List<RequestModel>> LoadRequest(String userId,String studentId);
}