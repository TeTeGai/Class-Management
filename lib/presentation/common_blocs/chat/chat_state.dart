import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/chat_model.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';

import '../../../data/model/text_model.dart';

class ChatState extends Equatable{
  const ChatState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class ChatLoading extends ChatState{}

class UserLoaded extends ChatState{
  final List<UserModel> userModel;
  UserLoaded(this.userModel);
  @override
  // TODO: implement props
  List<Object?> get props => [userModel];
}
class MessUserLoaded extends ChatState{
  final List<ChatModel> chatModel;
  MessUserLoaded(this.chatModel);
  @override
  // TODO: implement props
  List<Object?> get props => [chatModel];
}

class TextLoaded extends ChatState{
  final List<TextModel> textModel;
  TextLoaded(this.textModel);
  @override
  // TODO: implement props
  List<Object?> get props => [textModel];
}
class ChatLoadFail extends ChatState{}