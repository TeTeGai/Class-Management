import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/data/model/score_model.dart';

abstract class ScoreRepository{
  Stream<List<GPAModel>> LoadGoodGPA(String classId);
  Stream<List<GPAModel>> LoadBadGPA(String classId);
  Stream<List<ScoreModel>> LoadScore(String classId);
  Future<void> GPAStudentUpdateModel(int score,String classId,String studentId);
  Future<void> GPAAdd(GPAModel gpaModel,String classId);
  Future<void> GPAListAdd(String classId,String title,int score,String comment,String time,String idStudent, String sentBy,String img,String category );
  Future<void> ScoreAdd(ScoreModel scoreModel,String classId);
  Future<void> ScoreListAdd(String classId,String title,int score,String comment,String time,String idStudent,String sentBy,String img,String cateSelect);
}