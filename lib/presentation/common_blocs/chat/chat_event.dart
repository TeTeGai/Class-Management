import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/chat_model.dart';
import 'package:luan_an/data/model/text_model.dart';
import 'package:luan_an/data/model/user_model.dart';

class ChatEvent extends Equatable{
  const ChatEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChatLoadUser extends ChatEvent{
}
class MessLoadUser extends ChatEvent{
}

class UserUpdate extends ChatEvent{
  List<UserModel> userModel;
  UserUpdate(this.userModel);
  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}
class MessUserUpdate extends ChatEvent{
  List<ChatModel> chatModel;
  MessUserUpdate(this.chatModel);
  @override
  // TODO: implement props
  List<Object?> get props => [chatModel];
}

class ChatAdd extends ChatEvent{
  String recipientId;
  ChatModel chatModel1;
  ChatModel chatModel2;
  bool isGroup;
  ChatAdd(this.chatModel1,this.chatModel2,this.recipientId,this.isGroup);
  @override
  // TODO: implement props
  List<Object?> get props => [this.chatModel1,this.chatModel2,this.recipientId,isGroup];
}

class TextSent extends ChatEvent{
   String text;
   String lastMess;
   String senderId;
   String senderUsername;
   String recipientId;
   String  recipientUsername;
   String type;
   bool  isGroupChat;
   Timestamp time;
   TextSent(
       this.text,
       this.lastMess,
       this.senderId,
       this.senderUsername,
       this.recipientId,
       this.recipientUsername,
       this.type,
       this.isGroupChat,
       this.time,
       );
  @override
  // TODO: implement props
  List<Object?> get props => [
    this.text,
    this.lastMess,
    this.senderId,
    this.senderUsername,
    this.recipientId,
    this.recipientUsername,
    this.type,
    this.isGroupChat,
    this.time,
  ];
}

class TextLoad extends ChatEvent{
  final String recipientId;
  TextLoad(this.recipientId);
  @override
  // TODO: implement props
  List<Object?> get props => [recipientId];
}

class TextUpdate extends ChatEvent{
  final List<TextModel> listTextModel;
  TextUpdate(this.listTextModel);
  @override
  // TODO: implement props
  List<Object?> get props => [listTextModel];
}
