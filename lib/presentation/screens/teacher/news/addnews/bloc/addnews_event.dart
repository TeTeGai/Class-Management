import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../../../../data/model/news_model.dart';



class AddNewsEvent extends Equatable{
  const AddNewsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddNews extends AddNewsEvent{
  final NewsModel newsModel;
  final List file;



  AddNews(this.newsModel,this.file);
  @override
  // TODO: implement props
  List<Object?> get props => [newsModel,file];

}

class UpdateNews extends AddNewsEvent{
  final NewsModel newsModel;
  UpdateNews(this.newsModel);
  @override
  // TODO: implement props
  List<Object?> get props => [newsModel];
}