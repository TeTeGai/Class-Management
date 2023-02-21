
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel{
  final String id;
  final String avatar;
  final String name;
  final String title;
  final Timestamp timeCreate;
  final bool isSeen;

  NotificationModel(
      {
        required this.id,
        required this.avatar,
        required this.name,
        required this.title,
        required this.timeCreate,
        required this.isSeen});

  Map<String,dynamic> toMap()
  {
    return{
      'id':this.id,
      "avatar": this.avatar,
      "name": this.name,
      "timeCreate": Timestamp.now(),
      "title":this.title,
      "isSeen": false
    };
  }

  static NotificationModel formMap(Map<String,dynamic> data)
  {
    return NotificationModel(
        id: data["id"] ?? "",
        avatar: data["avatar"] ??"",
        name: data["name"]??"",
        title: data["title"] ?? "",
        isSeen: data["isSeen"] ?? false,
        timeCreate: data['timeCreate']??Timestamp.now());
  }
}