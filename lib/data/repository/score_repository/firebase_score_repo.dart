import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/data/model/score_model.dart';
import 'package:luan_an/data/repository/score_repository/score_repo.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/randomid.dart';


class FirebaseScoreRepository extends ScoreRepository{
  @override
  Stream<List<ScoreModel>> LoadScore(String classId) {
    var _gpacollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("score");
    return _gpacollection.snapshots().map((event) => event.docs.map((e) => ScoreModel.formMap(e.data())).toList());
  }

  @override
  Stream<List<GPAModel>> LoadGoodGPA(String classId) {
    var _gpacollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpa").where("category",isEqualTo: "GoodGPA").orderBy('timeCreate');
    return _gpacollection.snapshots().map((event) => event.docs.map((e) => GPAModel.formMap(e.data())).toList());
  }

  @override
  Stream<List<GPAModel>> LoadBadGPA(String classId) {
    var _gpacollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpa").where("category",isEqualTo: "BadGPA").orderBy('timeCreate');
    return _gpacollection.snapshots().map((event) => event.docs.map((e) => GPAModel.formMap(e.data())).toList());
  }

  @override
  Stream<List<GPAModel>> LoadListGPA(String classId,String idStudent) {
    var _gpacollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpaList").where("idStudent",isEqualTo: idStudent).orderBy('time');
    return _gpacollection.snapshots().map((event) => event.docs.map((e) => GPAModel.formListMap(e.data())).toList());
  }

  @override
  Stream<List<GPAModel>> LoadGoodSonGPA(String userId) {
    var _gpacollection = FirebaseFirestore.instance.collection("users").doc(userId).collection("gpa").where("category",isEqualTo: "GoodGPA").orderBy('timeCreate');
    return _gpacollection.snapshots().map((event) => event.docs.map((e) => GPAModel.formMap(e.data())).toList());
  }

  @override
  Stream<List<GPAModel>> LoadBadSonGPA(String userId) {
    var _gpacollection = FirebaseFirestore.instance.collection("users").doc(userId).collection("gpa").where("category",isEqualTo: "BadGPA").orderBy('timeCreate');
    return _gpacollection.snapshots().map((event) => event.docs.map((e) => GPAModel.formMap(e.data())).toList());
  }

  @override
  Future<void> GPAStudentUpdateModel(int score,String classId,String studentId) async {
    late int scoreStudent;
    await FirebaseFirestore.instance.collection("class").doc(classId)
        .collection("student").doc(studentId).get().then((querySnaphost)
    {
      var data = querySnaphost.data();
      scoreStudent = data!["score"];
    });

    return FirebaseFirestore.instance.collection("class").doc(classId)
        .collection("student").doc(studentId)
        .update({'score': scoreStudent + score});
  }

  @override
  Future<void> GPAAdd(GPAModel gpaModel,String classId) async{
    String random =RandomId();
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpa");
    gpaModel = gpaModel.cloneWith(id: random,);
    await _gpaCollection.doc(gpaModel.id).set(gpaModel.toMap());
  }

  @override
  Future<void> GPASonAdd(GPAModel gpaModel,String userId) async{
    String id = const Uuid().v1();
    var _gpaCollection = FirebaseFirestore.instance.collection("users").doc(userId).collection("gpa");
    gpaModel = gpaModel.cloneWith(id: id,);
    await _gpaCollection.doc(gpaModel.id).set(gpaModel.toMap());
  }

  @override
  Future<void> GPAListAdd(String classId,String title,int score,String comment,String time,String idStudent, String sentBy,String img,String category) async{
    String random =RandomId();
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpaList");
    await  _gpaCollection.doc(random).set(
        {
          "id":  random,
          "idStudent": idStudent,
          "title": title,
          "score": score,
          "comment": comment,
          "time": time,
          "sentBy": sentBy,
          "img": img,
          "category":category,
          "timeCreate":Timestamp.now()
        }
    );
  }

  @override
  Future<void> GPAHomeListAdd(String classId,String title,int score,String comment,String time,String idStudent, String sentBy,String img,String category) async{
    String random =RandomId();
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpaHomeList");
    await  _gpaCollection.doc(random).set(
        {
          "id":  random,
          "idStudent": idStudent,
          "title": title,
          "score": score,
          "comment": comment,
          "time": time,
          "sentBy": sentBy,
          "img": img,
          "category":category,
          "timeCreate":Timestamp.now()
        }
    );
  }


  @override
  Future<void> ScoreAdd(ScoreModel scoreModel, String classId) async{
    String random =RandomId();
    var _scoreCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("score");
    scoreModel = scoreModel.cloneWith(id: random,);
    await _scoreCollection.doc(scoreModel.id).set(scoreModel.toMap());
  }

  @override
  Future<void> ScoreListAdd(String classId, String title, int score, String comment, String time,String sentBy,String img, String idStudent,String cateSelect) async{
    String random =RandomId();
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("scoreList");
    await  _gpaCollection.doc(random).set(
        {
          "id":  random,
          "idStudent": idStudent,
          "title": title,
          "score": score,
          "comment": comment,
          "time": time,
          "sentBy": sentBy,
          "img": img,
          "cateSelect":cateSelect,
          "timeCreate":Timestamp.now()
        }
    );
  }

  @override
  Future<void> GpaUpdate(String classId,GPAModel gpaModel) async{
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpa");
    await  _gpaCollection.doc(gpaModel.id).update(
        {
          "title": gpaModel.title,
          "score": gpaModel.score,
          "avatar": gpaModel.avatar,
        }
    );
  }
  @override
  Future<void> GpaSonUpdate(GPAModel gpaModel) async{
    var _gpaCollection = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("gpa");
    await  _gpaCollection.doc(gpaModel.id).update(
        {
          "title": gpaModel.title,
          "score": gpaModel.score,
          "avatar": gpaModel.avatar,
        }
    );
  }
  @override
  Future<void> SourceUpdate(String classId,ScoreModel scoreModel) async{
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("score");
    await  _gpaCollection.doc(scoreModel.id).update(
        {
          "title": scoreModel.title,
          "score": scoreModel.score,
          "avatar": scoreModel.avatar,
          "category": scoreModel.category
        }
    );
  }

  @override
  Future<void> GPADelete(String classId,String gpaId) async{
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("gpa");
    await  _gpaCollection.doc(gpaId).delete();
  }

  @override
  Future<void> ScoreDelete(String classId,String scoreId) async{
    var _gpaCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("score");
    await  _gpaCollection.doc(scoreId).delete();
  }

  @override
  Future<void> GPASonDelete(String gpaSonId) async{
    var _gpaCollection = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("gpa");
    await  _gpaCollection.doc(gpaSonId).delete();
  }
}