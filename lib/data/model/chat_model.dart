import 'package:cloud_firestore/cloud_firestore.dart';

class ChatModel{
  final String name;
  final String contactId;
  final Timestamp time;
  final String profileUrl;
  final String lastMessage;
  ChatModel(
      {
      required this.name,
      required this.contactId,
      required this.time,
      required this.profileUrl,
        required this.lastMessage,
      });

  static ChatModel fromMap(Map<String, dynamic> data) {
    return ChatModel(
      name: data['name']??"",
      contactId: data['contactId']??"",
      time: data['time']??"",
        profileUrl: data['profileUrl']??"",
      lastMessage: data['lastMessage']??false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name':name,
      'contactId': contactId,
      'time': time,
      'profileUrl': profileUrl,
      'lastMessage':lastMessage,
    };
  }

  ChatModel cloneWith(
      {
        name,
        contactId,
        time,
        profileUrl,
        lastMessage
      }) {
    return ChatModel(
      name:name ?? this.name ,
      contactId: contactId?? this.contactId,
      time: time ?? this.time,
      profileUrl: profileUrl ?? this.profileUrl,
      lastMessage:lastMessage ?? this.lastMessage,);
  }
}