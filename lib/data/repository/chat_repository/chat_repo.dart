
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:luan_an/data/model/user_model.dart';
import '../../model/chat_model.dart';
import '../../model/text_model.dart';

abstract class ChatRepository{
  Stream<List<UserModel>> LoadUser(String userId,String currentId);
  Stream<List<UserModel>> LoadTeacherUser(String userId);
  Future<List>  loadUserInClass (String classId);
  Future<void> addToMyChat(String senderId,String recipientId,
      ChatModel chatModelCurrent, ChatModel chatModelOther,bool isGroupChat,
      String text);
  Future<void> sentMessage(
      String id,
      String text,
      String senderId,
      String recipientId,
      String senderUsername,
      String recipientUsername,
      Timestamp time,
      String type,
      bool isGroupChat,
      );
  Future<void> sentTextMessage(
      String text,
      String lastText,
      String senderId,
      String recipientId,
      String senderUsername,
      String recipientUsername,
      Timestamp time,
      String type,
      bool isGroupChat,
      );
  Stream<List<ChatModel>> LoadChat(String currentId);
  Stream<List<TextModel>> getChatStream(String senderId,String recipientId);
}