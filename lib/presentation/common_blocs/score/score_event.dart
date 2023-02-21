import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/data/model/score_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';

class ScoreEvent extends Equatable{
  ScoreEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScoreAdd extends ScoreEvent{
  ScoreModel scoreModel;

  ScoreAdd(this.scoreModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scoreModel];
}
class ScoreListAdd extends ScoreEvent{
  final String title;
  final int score;
  final String comment;
  final String time;
  final String idStudent;
  final String sentBy;
  final String img;
  final String cateSelect;
  final String? userId;
  final String notiTitle;
  ScoreListAdd(this.title,this.score,this.comment,this.time,this.idStudent,this.sentBy,this.img,this.userId,this.notiTitle,this.cateSelect);
  @override
  // TODO: implement props
  List<Object?> get props => [title,score,comment,time,idStudent,sentBy,img,userId,notiTitle,];
}
class GpaAdd extends ScoreEvent{
  GPAModel gpaModel;
  GpaAdd(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}
class GpaDelete extends ScoreEvent{
  String gpaId;
  GpaDelete(this.gpaId);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaId];
}
class GpaSonDelete extends ScoreEvent{
  String gpaSonId;
  GpaSonDelete(this.gpaSonId);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaSonId];
}

class ScoreDelete extends ScoreEvent{
  String scoreId;
  ScoreDelete(this.scoreId);
  @override
  // TODO: implement props
  List<Object?> get props => [scoreId];
}
class GpaSonAdd extends ScoreEvent{
  GPAModel gpaModel;
  GpaSonAdd(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class GpaListAdd extends ScoreEvent{
  final String title;
  final int score;
  final String comment;
  final String time;
  final String idStudent;
  final String sentBy;
  final String img;
  final String category;
  GpaListAdd(this.title,this.score,this.comment,this.time,this.idStudent,this.sentBy,this.img,this.category);
  @override
  // TODO: implement props
  List<Object?> get props => [title,score,comment,time,sentBy,img,category];
}
class GpaHomeListAdd extends ScoreEvent{
  final String classId;
  final String title;
  final int score;
  final String comment;
  final String time;
  final String idStudent;
  final String sentBy;
  final String img;
  final String category;
  GpaHomeListAdd(this.classId,this.title,this.score,this.comment,this.time,this.idStudent,this.sentBy,this.img,this.category);
  @override
  // TODO: implement props
  List<Object?> get props => [classId,title,score,comment,time,sentBy,img,category];
}
class GPAGoodLoad extends ScoreEvent{
}
class GPABadLoad extends ScoreEvent{
}
class GPAListLoad extends ScoreEvent{
  final String idStudent;
  GPAListLoad(this.idStudent);
  @override
  // TODO: implement props
  List<Object?> get props => [idStudent];
}
class GPAGoodSonLoad extends ScoreEvent{
}
class GPABadSonLoad extends ScoreEvent{
}

class ScoreLoad extends ScoreEvent{
}
class GPAModelUpdate extends ScoreEvent{
  GPAModel gpaModel;
  GPAModelUpdate(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class GPASonModelUpdate extends ScoreEvent{
  GPAModel gpaModel;
  GPASonModelUpdate(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}
class ScoreModelUpdate extends ScoreEvent{
  ScoreModel scoreModel;
  ScoreModelUpdate(this.scoreModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scoreModel];
}
class GPAGoodUpdate extends ScoreEvent{
  List<GPAModel> gpaModel;
  GPAGoodUpdate(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}
class GPABadUpdate extends ScoreEvent{
  List<GPAModel> gpaModel;
  GPABadUpdate(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}
class GPAListUpdate extends ScoreEvent{
  List<GPAModel> gpaModel;
  GPAListUpdate(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class GPAGoodSonUpdate extends ScoreEvent{
  List<GPAModel> gpaModel;
  GPAGoodSonUpdate(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}
class GPABadSonUpdate extends ScoreEvent{
  List<GPAModel> gpaModel;
  GPABadSonUpdate(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class GPAStudentUpdateModel extends ScoreEvent{
  final int score;
  final String studentId;
  final String title;
  final dynamic userId;
  GPAStudentUpdateModel(this.score,this.studentId,this.title,this.userId);
  @override
  // TODO: implement props
  List<Object?> get props => [score,studentId];
}

class ScoreUpdate extends ScoreEvent{
  List<ScoreModel> scoreModel;
  ScoreUpdate(this.scoreModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scoreModel];
}