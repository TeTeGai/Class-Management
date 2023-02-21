import 'package:equatable/equatable.dart';

class AddSonState extends Equatable{
  const AddSonState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddSuccess extends AddSonState{}

class AddingSon extends AddSonState{}

class AddFail extends AddSonState{}