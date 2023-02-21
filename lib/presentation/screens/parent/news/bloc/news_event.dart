import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/data/model/user_model.dart';

class NewsEvent extends Equatable{
  const NewsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class NewsLoad extends NewsEvent{}

class NewsParentLoad extends NewsEvent{}

class LikesLoadUser extends NewsEvent{
  List listLikes;
  LikesLoadUser(this.listLikes);
  @override
  // TODO: implement props
  List<Object?> get props => [listLikes];
}

class UpdateNews extends NewsEvent{
  final List<NewsModel> newsModel;
  UpdateNews(this.newsModel);
  @override
  // TODO: implement props
  List<Object?> get props => [newsModel];
}

class UpdateParentNews extends NewsEvent{
  final List<NewsModel> newsModel;
  UpdateParentNews(this.newsModel);
  @override
  // TODO: implement props
  List<Object?> get props => [newsModel];
}

class UpdateLikesNews extends NewsEvent{
  final List<UserModel> listLikes;
  UpdateLikesNews(this.listLikes);
  @override
  // TODO: implement props
  List<Object?> get props => [listLikes];
}
class NewsLikesLoad extends NewsEvent{
  final List like;
  final String postId;
  final String classId;
  NewsLikesLoad(this.like,this.postId,this.classId);
  @override
  // TODO: implement props
  List<Object?> get props => [like,postId,classId];
}

class NewsLikesParentLoad extends NewsEvent{
  final List like;
  final String postId;
  final String classId;
  NewsLikesParentLoad(this.like,this.postId,this.classId);
  @override
  // TODO: implement props
  List<Object?> get props => [like,postId,classId];
}