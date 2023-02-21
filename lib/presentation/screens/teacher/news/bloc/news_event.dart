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

class DeleteNews extends NewsEvent{
  final String postId;
  DeleteNews(this.postId);
  @override
  // TODO: implement props
  List<Object?> get props => [postId];
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
  NewsLikesLoad(this.like,this.postId);
  @override
  // TODO: implement props
  List<Object?> get props => [like,postId];
}