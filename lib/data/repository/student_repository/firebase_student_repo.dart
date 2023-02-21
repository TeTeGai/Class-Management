import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/request_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/data/repository/student_repository/student_repo.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/randomid.dart';
import '../img_repository/firebase_img_repo.dart';

class FirebaseStudentRepository extends StudentRepository{

  @override
  Future<void> AddStudent(String nameText,String classId) async{
    String random =RandomId();
    Timestamp timestamp = Timestamp.now();
    StudentModel studentModel = StudentModel(
        id: random,
        name: nameText,
        avatar: "https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Favatar%2F31818797506_41e52a8b36.jpg?alt=media&token=18cff330-c239-4025-bf44-befd5216dde2",
        idParent: null,
        idSon: null,
        score: 0,
        time: timestamp,
        isConnect: false,
        rollCall: 0,
    );
    var _studentcollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("student");
    await _studentcollection.doc(studentModel.id).set(studentModel.toMap());
  }

  @override
  Future<void> AddRollCall(String classId,String name,int rollCall,String time) async{
    String id = const Uuid().v1();
    var _rollCallCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("rollCall");
    await  _rollCallCollection.doc(id).set(
        {
          "id":  id,
          "name": name,
          "time": time,
          "rollCall":rollCall
        }
    );
  }

  @override
  Future<void> AddRequest(String title,String content,String img,String classId,String idStudent) async{
    String id = const Uuid().v1();
    Timestamp timestamp = Timestamp.now();
    RequestModel requestModel = RequestModel(
        id: id,
        title: title,
        content: content,
        timeCreate: timestamp,
        img: img,
        idStudent: idStudent,
        appcept: false);
    var _studentcollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("request");
    await _studentcollection.doc(id).set(requestModel.toMap());
  }

  @override
  Stream<List<RequestModel>> LoadRequest(String classId,String idStudent) {
    var _studentcollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("request").where('idStudent',isEqualTo: idStudent).orderBy('timeCreate');
    return _studentcollection.snapshots().map((event) => event.docs.map((e) => RequestModel.formMap(e.data())).toList());
  }


  @override
  Future<void> RemoveRequest(String classId,String requestId,) async{
    await FirebaseFirestore.instance.collection("class").doc(classId).collection("request").doc(requestId).delete();
  }

  @override
  Stream<List<StudentModel>> LoadStudent(String classId) {
    var _studentcollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("student").orderBy('timeCreate');
    return _studentcollection.snapshots().map((event) => event.docs.map((e) => StudentModel.formMap(e.data())).toList());
  }

  @override
  Future<void> AddSons(StudentModel studentModel,String userId,Uint8List? file,String? img) async{
    if(file!= null)
      {
        String photoUrl = await FirebaseImgRepository().uploadImageToStorage( file!, true);
        studentModel = studentModel.cloneWith(avatar: photoUrl);
        var _studentcollection = FirebaseFirestore.instance.collection("users").doc(userId).collection("sons");

        await _studentcollection.doc(studentModel.id).set(studentModel.sonToMap());
      }
    else{
      studentModel = studentModel.cloneWith(avatar: img);
      var _studentcollection = FirebaseFirestore.instance.collection("users").doc(userId).collection("sons");

      await _studentcollection.doc(studentModel.id).set(studentModel.sonToMap());
    }

  }

  @override
  Stream<List<StudentModel>> LoadSons(String userId) {
    var _studentcollection = FirebaseFirestore.instance.collection("users").doc(userId).collection("sons").orderBy('timeCreate');
    return _studentcollection.snapshots().map((event) => event.docs.map((e) => StudentModel.sonFormMap(e.data())).toList());
  }

  @override
  Stream<List<StudentModel>> LoadStudentParent(String classId) {
    var _studentcollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("student").where("isConnect",isEqualTo: true).orderBy('timeCreate');
    return _studentcollection.snapshots().map((event) => event.docs.map((e) => StudentModel.formMap(e.data())).toList());
  }

  @override
  Stream<List<StudentModel>> LoadStudentNoParent(String classId) {
    var _studentcollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("student").where("isConnect",isEqualTo: false).orderBy('timeCreate');
    return _studentcollection.snapshots().map((event) => event.docs.map((e) => StudentModel.formMap(e.data())).toList());
  }

  @override
  Future<void> AddParentStudent(String idParent,String classId,String studentId,) async{
     return FirebaseFirestore.instance.collection("class").doc(classId)
        .collection("student").doc(studentId).update(
      {
        'isConnect' : true,
        'idParent':idParent,
      }
    );
  }

  @override
  Future<void> ConnectSonToClass(String idParent,String sonId,String studentId,String classId) async{
    return FirebaseFirestore.instance.collection("users").doc(idParent)
        .collection("sons").doc(sonId).update(
        {
          'isConnect' : true,
          'idStudent':studentId,
          'idClass':classId,
        }
    );
  }
  @override
  Future<void> editStudent(StudentModel studentModel,Uint8List? file,String? img,String classId) async {
    if(file!= null)
    {
      String photoUrl = await FirebaseImgRepository().uploadImageToStorage( file, true);
      FirebaseFirestore.instance.collection("class").doc(classId).collection("student").doc(studentModel.id).update(
          {
            'name':studentModel.name,
            'avatar':photoUrl,
          }
      );
    }
    else{
      FirebaseFirestore.instance.collection("class").doc(classId).collection("student").doc(studentModel.id).update(
          {
           'name':studentModel.name,
          'avatar':img,
          }
      );
    }
  }
  @override
  Future<void> editSon(StudentModel studentModel,Uint8List? file,String? img) async {
    if(file!= null)
    {
      String photoUrl = await FirebaseImgRepository().uploadImageToStorage( file, true);
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("sons").doc(studentModel.id).update(
          {
            'name':studentModel.name,
            'avatar':photoUrl,
          }
      );
    }
    else{
      FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("sons").doc(studentModel.id).update(
      {
            'name':studentModel.name,
            'avatar':img,
          }
      );
    }
  }
  @override
  Future<void> RemoveStudent(String studentId,String classId) async{
    return FirebaseFirestore.instance.collection("class").doc(classId).collection('student').doc(studentId).delete();
  }
  @override
  Future<void> RemoveSon(String sonId,) async{
    return FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection('sons').doc(sonId).delete();
  }


  @override
  Future<StudentModel> getStudentByID(String classId,String studentId) async{
    return await  FirebaseFirestore.instance.collection("class").doc(classId).collection('student').doc(studentId)
        .get()
        .then((doc) => StudentModel.formMap(doc.data()!));
  }


  @override
  Future<void> UpdateRequest(String classId,String requestId) async {

      FirebaseFirestore.instance.collection("class").doc(classId).collection("request").doc(requestId).update(
          {
            'appcept': true,
          }
      );

  }
}