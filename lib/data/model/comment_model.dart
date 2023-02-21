import 'package:cloud_firestore/cloud_firestore.dart';

class CommentModel
{
  final String id;
  final String name;
  final String profilePic;
  final String comment;
  final Timestamp timeCmt;
  final List likes;

  CommentModel(
      {
        required this.id,
        required this.name,
        required this.profilePic,
        required this.comment,
        required this.timeCmt,
        required this.likes,
      });

  Map<String,dynamic> toMap()
  {
    return
        {
          'id':this.id,
          'name':this.name,
          'profilePic':this.profilePic,
          'comment': this.comment,
          'timeCmt': this.timeCmt,
          'likes':this.likes
        };
  }
  static CommentModel formMap(Map<String,dynamic> data)
  {
    return CommentModel(
        id: data['id']??"",
        name: data['name']??"",
        profilePic: data['profilePic']??"",
        comment: data["comment"]??"",
        timeCmt: data['timeCmt']??"",
        likes: data['likes']??[]);
  }

  CommentModel cloneWith(
  {
    id,
    name,
    profilePic,
    comment,
    timeCmt,
    likes
  })
  {
    return CommentModel(
        id: id ?? this.id,
        name: name ?? this.name,
        profilePic: profilePic ?? this.profilePic,
        comment: comment ?? this.comment,
        timeCmt: timeCmt ?? this.timeCmt,
        likes: likes ?? this.likes);
  }
}