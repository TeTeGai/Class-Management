import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/gpa_model.dart';
import 'package:luan_an/data/model/score_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';

class ScoreState extends Equatable{
  const ScoreState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ScoreLoading extends ScoreState{}
class GPALoading extends ScoreState{}

class GPAGoodLoaded extends ScoreState{
   List<GPAModel> gpaModel;
   GPAGoodLoaded(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class GPAListLoaded extends ScoreState{
  List<GPAModel> gpaModel;
  GPAListLoaded(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}
class GPABadLoaded extends ScoreState{
  List<GPAModel> gpaModel;
  GPABadLoaded(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class GPAGoodSonLoaded extends ScoreState{
  List<GPAModel> gpaModel;
  GPAGoodSonLoaded(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class GPABadSonLoaded extends ScoreState{
  List<GPAModel> gpaModel;
  GPABadSonLoaded(this.gpaModel);
  @override
  // TODO: implement props
  List<Object?> get props => [gpaModel];
}

class ScoreLoaded extends ScoreState{
  List<ScoreModel> scoreModel;
  ScoreLoaded(this.scoreModel);
  @override
  // TODO: implement props
  List<Object?> get props => [scoreModel];
}

class ScoreLoadFail extends ScoreState{
  final String eror;
  ScoreLoadFail(this.eror);
  @override
  // TODO: implement props
  List<Object?> get props => [this.eror];
}

class GPALoadFail extends ScoreState{
  final String eror;
  GPALoadFail(this.eror);
  @override
  // TODO: implement props
  List<Object?> get props => [this.eror];
}
