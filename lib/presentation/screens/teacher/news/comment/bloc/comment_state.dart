import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/comment_model.dart';

class CommentState extends Equatable{
  const CommentState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CommentLoading extends CommentState{}

class CommentLoaded extends CommentState{
  final List<CommentModel> cmtModel;
  CommentLoaded(this.cmtModel);
  @override
  // TODO: implement props
  List<Object?> get props => [cmtModel];
}

class CommentLoadFail extends CommentState{
  final String error;
  CommentLoadFail(this.error);
  @override
  // TODO: implement props
  List<Object?> get props => [error];
}