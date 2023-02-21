
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:luan_an/data/model/chat_model.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:uuid/uuid.dart';

import '../../model/text_model.dart';
import 'chat_repo.dart';

class FirebaseChatRepository extends ChatRepository
{
  List listLoadUser =[];
  String nameClass ='';
  String avatar ='';

  @override
  Stream<List<UserModel>> LoadUser(String userId,String currentId)  {
    var _usercollection =FirebaseFirestore.instance.collection("users").where('id',isEqualTo: userId,isNotEqualTo: currentId);
    return _usercollection.snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data())).toList());

  }

  @override
  Stream<List<UserModel>> LoadTeacherUser(String userId)  {
    var _usercollection =FirebaseFirestore.instance.collection("users").where('id',isEqualTo: userId,).where('role',isEqualTo: "teacher");
    return _usercollection.snapshots().map((event) => event.docs.map((e) => UserModel.fromMap(e.data())).toList());

  }
  
  @override
  Future<List> loadUserInClass(String classId) async {
    var _classcollection =FirebaseFirestore.instance.collection("class");
    await _classcollection.doc(classId).get().then((value) {
      List.from( value.data()!["member"]).forEach((element) {
        listLoadUser.add(element);
      });
    });
    return listLoadUser.toList();
  }
  @override
  Future<String> loadNameClass(String classId) async {
    var _classcollection =FirebaseFirestore.instance.collection("class");
    await _classcollection.doc(classId).get().then((value) {
      nameClass =value.data()!["className"];
    });
    return nameClass;
  }
  @override
  Future<String> loadAvatarClass(String classId) async {
    var _classcollection =FirebaseFirestore.instance.collection("class");
    await _classcollection.doc(classId).get().then((value) {
      avatar =value.data()!["avatar"];
    });
    return avatar;
  }


  @override
  Future<void> addToMyChat(String senderId,String recipientId,
      ChatModel chatModelCurrent, ChatModel chatModelOther,bool isGroupChat,
      String text)
  async {
    if(isGroupChat)
      {
        await FirebaseFirestore.instance
            .collection('groups')
            .doc(recipientId)
            .update({
          'lastMessage': text,
          'time': DateTime.now().millisecondsSinceEpoch,
        });
      }
    else{
      final myChatRef = FirebaseFirestore.instance
          .collection("users")
          .doc(senderId)
          .collection("myChat");
      final otherChatRef = FirebaseFirestore.instance
          .collection("users")
          .doc(recipientId)
          .collection("myChat");
      chatModelCurrent = chatModelCurrent.cloneWith(lastMessage: text);
      chatModelOther = chatModelOther.cloneWith(lastMessage: text);
      myChatRef.doc(recipientId).get().then((myChatDoc) {
        if (!myChatDoc.exists) {
          myChatRef.doc(recipientId).set(chatModelCurrent.toMap());
          otherChatRef.doc(senderId).set(chatModelOther.toMap());
          return;
        } else {
          // print("update");
          // myChatRef.doc(recipientId).update(chatModelCurrent.toMap());
          // otherChatRef.doc(senderId).set(chatModelOther.toMap());
          return;
        }
      });
    }

  }

  @override
  Stream<List<ChatModel>> LoadChat(String currentId) {
    var _usercollection = FirebaseFirestore.instance.collection("users").doc(currentId).collection("myChat");
    return _usercollection.snapshots().map((event) => event.docs.map((e) => ChatModel.fromMap(e.data())).toList());
  }

  @override
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
      ) async {
    TextModel textModel = TextModel(
        id: id,
        text: text,
        senderId: senderId,
        recieverId: recipientId,
        time: time,
        type: type,
        isSeen: false,
       );
    if (isGroupChat) {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(recipientId)
          .collection('myChat')
          .doc(id)
          .set(
        textModel.toMap(),
      );
    }
    else {
      // users -> sender id -> reciever id -> messages -> message id -> store message
      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('myChat')
          .doc(recipientId)
          .collection('messages')
          .doc(id)
          .set(
        textModel.toMap(),
      );
      // users -> eciever id  -> sender id -> messages -> message id -> store message
      await FirebaseFirestore.instance
          .collection('users')
          .doc(recipientId)
          .collection('myChat')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('messages')
          .doc(id)
          .set(
        textModel.toMap(),
      );
    }
  }

  @override
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
      ) async {
    var id = const Uuid().v1();

    sentMessage(
       id,
       text,
       senderId,
       recipientId,
       senderUsername,
       recipientUsername,
       time,
       type,
       isGroupChat,);

    if(isGroupChat)
    {
      await FirebaseFirestore.instance
          .collection('groups')
          .doc(recipientId)
          .update({
        'lastMessage': text,
        'time': DateTime.now().millisecondsSinceEpoch,
      });
    }
    else{
      final myChatRef = FirebaseFirestore.instance
          .collection("users")
          .doc(senderId)
          .collection("myChat");
      final otherChatRef = FirebaseFirestore.instance
          .collection("users")
          .doc(recipientId)
          .collection("myChat");

          myChatRef.doc(recipientId).update(
            {
              'lastMessage':lastText
            }
          );
          otherChatRef.doc(senderId).update(
              {
                'lastMessage':lastText
              }
          );

      };
    }



  Stream<List<TextModel>> getChatStream(String senderId,String recipientId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(senderId)
        .collection('myChat')
        .doc(recipientId)
        .collection('messages')
        .orderBy('time')
        .snapshots()
        .map((event) {
      List<TextModel> messages = [];
      for (var document in event.docs) {
        messages.add(TextModel.fromMap(document.data()));
      }
      return messages;
    });
  }
}