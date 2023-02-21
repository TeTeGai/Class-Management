import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';




class ConnectSonEvent extends Equatable{
  const ConnectSonEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ClassIdChange extends ConnectSonEvent{
  final String classId;
  ClassIdChange(this.classId);
  @override
  // TODO: implement props
  List<Object?> get props => [this.classId];
}

class Submit extends ConnectSonEvent{
  String classId;
  String sonId;
  BuildContext context;
  Submit(this.classId,this.sonId,this.context);
  @override
  // TODO: implement props
  List<Object?> get props => [classId,sonId,context];
}

