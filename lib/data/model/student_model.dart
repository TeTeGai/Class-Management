import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StudentModel{
  final String id;
  final String? classId;
  final String? idStudent;
  final String? idSon;
  final String name;
  final String avatar;
  final dynamic idParent;
  final int score;
  final Timestamp time;
  final bool isConnect;
  final int? rollCall;
   StudentModel({
    required this.id,
     this.classId,
    this.idStudent,
     this.idSon,
    required this.name,
    required this.avatar,
    required this.idParent,
    required this.score,
    required this.time,
    required this.isConnect,
     this.rollCall
    });

  Map<String, dynamic> toMap()
  {
    return{
      "id": this.id,
      "idSon": this.idSon,
      "name": this.name,
      "avatar": this.avatar,
      "idParent": this.idParent,
      "score": this.score,
      "timeCreate": this.time,
      "isConnect": this.isConnect,
      "rollCall":this.rollCall,
    };
  }

  Map<String, dynamic> sonToMap()
  {
    return{
      "id": this.id,
      "idStudent":this.idStudent,
      "idClass": this.classId,
      "name": this.name,
      "score": this.score,
      "avatar": this.avatar,
      "idParent": this.idParent,
      "timeCreate": this.time,
      "isConnect": this.isConnect,
    };
  }

  static StudentModel formMap(Map<String,dynamic>data)
  {
    return StudentModel(
        id: data["id"]??"",
        idSon:data["idSon"]??"",
        name: data["name"]??"",
        avatar: data["avatar"]??"",
        idParent: data["idParent"]??null,
        score:  data["score"]?? 0,
      time: data["timeCreate"] ?? Timestamp.now(),
      isConnect: data["isConnect"]??false,
      rollCall: data["rollCall"]??0,
    );
  }

  static StudentModel sonFormMap(Map<String,dynamic>data)
  {
    return StudentModel(
        id: data["id"]??"",
        idStudent:data["idStudent"]??"",
        classId:  data['idClass']??'',
        name: data["name"]??"",
        avatar: data["avatar"]??"",
        idParent: data["idParent"]??null,
        score:  data["score"]?? 0,
        time: data["timeCreate"] ?? Timestamp.now(),
        isConnect: data["isConnect"]??false,
    );
  }
  StudentModel cloneWith({
    id,
    name,
    avatar,
    idParent,
    score,
    time,
    isConnect
  })
  {
    return StudentModel(
        id: id ?? this.id,
        name: name ?? this.name,
        avatar: avatar ?? this.avatar,
        idParent: idParent ?? this.idParent,
        score: score ?? this.score,
        time: time ?? this.time,
        isConnect: isConnect ?? this.isConnect
    );
  }

}