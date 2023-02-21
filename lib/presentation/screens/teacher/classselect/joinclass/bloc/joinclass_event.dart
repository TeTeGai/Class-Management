import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../../../../../data/model/class_model.dart';



class JoinClassEvent extends Equatable{
  const JoinClassEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class Submit extends JoinClassEvent{
  String classId;
  BuildContext context;
  Submit(this.classId,this.context);
  @override
  // TODO: implement props
  List<Object?> get props => [classId,context];
}

