
class ScoreModel{
  final String id;
  final String title;
  final String avatar;
  final int score;
  final List category;
  ScoreModel({
    required this.id,
    required this.title,
    required this.avatar,
    required this.score,
    required this.category
  });

  Map<String,dynamic> toMap()
  {
    return{
      "id": this.id,
      "title": this.title,
      "avatar": this.avatar,
      "score": this.score,
      "category": this.category
    };
  }
  static ScoreModel formMap(Map<String,dynamic> data)
  {
    return ScoreModel(
        id: data["id"]??"",
        title: data["title"]??"",
        avatar: data["avatar"]??"",
        score:  data["score"]?? 0,
        category:  List<String>.from(data["category"]??""));
  }

  ScoreModel cloneWith({
    id,
    title,
    avatar,
    score,
    category
  })
  {
    return ScoreModel(
        id: id ?? this.id,
        title: title ??this.title,
        avatar: avatar ?? this.avatar,
        score: score ?? this.score,
        category: category ?? this.category);
  }
}