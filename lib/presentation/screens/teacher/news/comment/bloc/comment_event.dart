import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/comment_model.dart';

class CommentEvent extends Equatable{
  const CommentEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class CommentLoad extends CommentEvent{
  String posId;
  CommentLoad(this.posId);
  @override
  // TODO: implement props
  List<Object?> get props => [posId];
}

class CommentUpdate extends CommentEvent{
  final List<CommentModel> cmtModel;
  CommentUpdate(this.cmtModel);
  @override
  // TODO: implement props
  List<Object?> get props => [cmtModel];
}

class CommentAdd extends CommentEvent{
  final CommentModel cmtModel;
  final String cmt;
  final String postId;
  CommentAdd(this.cmtModel,this.cmt,this.postId);
  @override
  // TODO: implement props
  List<Object?> get props => [cmtModel,cmt,postId];
}