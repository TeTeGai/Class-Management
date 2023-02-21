import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/news_model.dart';

class AddNewsState extends Equatable{
  const AddNewsState ();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddingNews extends AddNewsState{}


class AddFailNews extends AddNewsState{
  final String eror;
  AddFailNews(this.eror);
  @override
  // TODO: implement props
  List<Object?> get props => [eror];
}