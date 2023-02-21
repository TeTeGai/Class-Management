import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/data/model/user_model.dart';

class NewsState extends Equatable{
  const NewsState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class NewsLoading extends NewsState{}

class NewsLoaded extends NewsState{
  final List<NewsModel> newsModel;
  NewsLoaded(this.newsModel);
  @override
  // TODO: implement props
  List<Object?> get props => [newsModel];
}
class ListLikesLoaded extends NewsState{
  final List<UserModel> listLikes;
  ListLikesLoaded(this.listLikes);
  @override
  // TODO: implement props
  List<Object?> get props => [listLikes];
}
class NewsLoadFail extends NewsState{
  final String eror;
  NewsLoadFail(this.eror);
  @override
  String toString() {
    eror.toString();
    return super.toString();
  }
}

class NewsLikeLoaded extends NewsState{}