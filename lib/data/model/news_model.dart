import 'package:cloud_firestore/cloud_firestore.dart';

class NewsModel{
  final String id;
  final String classId;
  final String text;
  final String idUser;
  final String nameUser;
  final String avatarUser;
  final List likes;
  final String postId;
  final List porfImg;
  final Timestamp datePost;

  NewsModel(
      { required this.id,
        required this.classId,
        required this.text,
        required this.idUser,
        required this.nameUser,
        required this.avatarUser,
        required this.likes,
        required this.postId,
        required this.porfImg,
        required this.datePost});

  Map<String,dynamic> toMap()
  {
    return
    {
      'id': this.id,
      'classId': this.classId,
      'text': this.text,
      'idUser': this.idUser,
      'nameUser': this.nameUser,
      'avatarUser':this.avatarUser,
      'likes': this.likes,
      'postId': this.postId,
      'porfImg': this.porfImg,
      'datePost': this.datePost
    };
  }
  static NewsModel formMap(Map<String,dynamic> data)
  {
    return NewsModel(
        id: data['id'] ?? "",
        classId:  data['classId']??"",
        text: data['text']??"",
        idUser: data['idUser']??"",
        nameUser: data['nameUser']??'',
        avatarUser: data['avatarUser']??'',
        likes: data['likes']??"",
        postId: data["postId"]??"",
        porfImg: List.from(data["porfImg"]??[]),
        datePost: data["datePost"]??"");
  }
  factory NewsModel.fromDocument(DocumentSnapshot doc) {
    return NewsModel(
        id: doc['id'] ?? "",
        classId: doc['classId']??"",
        text: doc['text']??"",
        idUser: doc['idUser']??"",
        nameUser: doc['nameUser']??'',
        avatarUser: doc['avatarUser']??'',
        likes: doc['likes']??"",
        postId: doc["postId"]??"",
        porfImg: List.from(doc["porfImg"]??[]),
        datePost: doc["datePost"]??"");
  }

  NewsModel cloneWith({
    id,
    classId,
    text,
    idUser,
    nameUser,
    avatarUser,
    likes,
    postId,
    porfImg,
    datePost,
})
  {
    return NewsModel(
        id: id ?? this.id,
        classId: classId ??this.classId,
        text: text ?? this.text,
        idUser: idUser??this.idUser,
        nameUser: nameUser?? this.nameUser,
        avatarUser: avatarUser?? this.avatarUser,
        likes: likes ?? this.likes,
        postId: postId ?? this.postId,
        porfImg: porfImg ?? this.porfImg,
        datePost: datePost?? this.datePost);
  }
}