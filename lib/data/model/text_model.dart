import 'package:cloud_firestore/cloud_firestore.dart';


class TextModel{
  final String id;
  final String text;
  final String senderId;
  final String recieverId;
  final Timestamp time;
  final String type;
  final bool isSeen;


  TextModel(
      {required this.id,
        required this.text,
        required this.senderId,
        required this.recieverId,
        required this.time,
        required this.type,
        required this.isSeen,
      });

  static TextModel fromMap(Map<String, dynamic> data) {
    return TextModel(
      id: data['id'] ??"",
      text: data['text']??"",
      senderId: data['senderId']??"",
      recieverId: data['recieverId']??"",
      time: data['time']??"",
      type: data['type']??"",
      isSeen: data['isSeen']??"",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      'text': text,
      'senderId': senderId,
      'recieverId': recieverId,
      'time': time,
      'type':type,
      'isSeen': isSeen,
    };
  }

  TextModel cloneWith(
      {
        id,
        text,
        senderId,
        recieverId,
        time,
        type,
        isSeen,
      }) {
    return TextModel(
        id: id ?? this.id,
         text: text ?? this.text,
        senderId: senderId ?? this.senderId,
      recieverId: recieverId?? this.recieverId,
        time: time ?? this.time,
        type: type?? this.type,
      isSeen: isSeen ?? this.isSeen,

     );
  }
}