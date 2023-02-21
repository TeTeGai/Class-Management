import 'dart:io';
import 'dart:typed_data';

import 'package:luan_an/data/model/comment_model.dart';
import 'package:luan_an/data/model/news_model.dart';

abstract class NewsRepository {
  Future<void> AddNews(NewsModel newsModel,String thisclass, List<File> file);
  Stream<List<NewsModel>> LoadNews(String thisclass);
  Future<void> likeNews(String postId, String uid, List like, String thisclass);
  Future<void> AddCmt(CommentModel cmtModel,String thisclass, String thispost);
  Stream<List<CommentModel>> LoadCmt(String thisclass,thispost);
}