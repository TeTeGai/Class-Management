import 'package:cloud_firestore/cloud_firestore.dart';

class RequestModel{
  final String id;
  final String title;
  final String content;
  final Timestamp timeCreate;
  final String img;
  final String idStudent;
  final bool appcept;

  RequestModel(
      {
        required this.id,
        required this.title,
        required this.content,
        required this.timeCreate,
        required this.img,
        required this.idStudent,
        required this.appcept
      });

  Map<String,dynamic> toMap()
  {
    return{
      'id':this.id,
      'title':this.title,
      'content':this.content,
      'timeCreate':this.timeCreate,
      'img':this.img,
      'idStudent': this.idStudent,
      'appcept':this.appcept,
    };
  }

  static RequestModel formMap(Map<String,dynamic> data)
  {
    return RequestModel(
        id: data["id"] ?? "",
        title: data["title"] ??"",
        content: data["content"] ?? "",
        timeCreate: data["timeCreate"] ?? "",
        img: data["img"] ??"",
        idStudent: data["idStudent"]??"",
        appcept: data["appcept"] ??false);
  }

}