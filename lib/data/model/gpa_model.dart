import 'package:cloud_firestore/cloud_firestore.dart';

class GPAModel{
  final String id;
  final String title;
  final String avatar;
  final int score;
  final String category;
  final Timestamp? timeCreate;
  final String? time;
  final String? sentBy;
  GPAModel({
    required this.id,
    required this.title,
    required this.avatar,
    required this.score,
    required this.category,
     this.timeCreate,
    this.time,
    this.sentBy,
  });

  Map<String,dynamic> toMap()
  {
    return{
      "id": this.id,
      "title": this.title,
      "avatar": this.avatar,
      "score": this.score,
      "category": this.category,
      "timeCreate":Timestamp.now()
    };
  }
  static GPAModel formMap(Map<String,dynamic> data)
  {
    return GPAModel(
        id: data["id"]??"",
        title: data["title"]??"",
        avatar: data["avatar"]??"",
        score:  data["score"]?? 0,
        category:  data["category"]??"",
      timeCreate: data['timeCreate']?? Timestamp.now(),
    );
  }

  static GPAModel formListMap(Map<String,dynamic> data)
  {
    return GPAModel(
      id: data["id"]??"",
      title: data["title"]??"",
      avatar: data["img"]??"",
      score:  data["score"]?? 0,
      category:  data["category"]??"",
      time: data['time'],
      sentBy:  data['sentBy']??"",
    );
  }

  GPAModel cloneWith({
    id,
    title,
    avatar,
    score,
    category,
    timeCreate,
  })
  {
    return GPAModel(
        id: id ?? this.id,
        title: title ??this.title,
        avatar: avatar ?? this.avatar,
        score: score ?? this.score,
        category: category ?? this.category,
        timeCreate: timeCreate?? this.timeCreate);
  }
}