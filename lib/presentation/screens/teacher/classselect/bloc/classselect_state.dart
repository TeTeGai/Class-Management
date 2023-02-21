import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/model/class_model.dart';


abstract class ClassSelectSate extends Equatable{
  const ClassSelectSate();

  @override
  List<Object> get props => [];
}

class ClassLoading extends ClassSelectSate{}

class ClassLoaded extends ClassSelectSate {
  final List<ClassModel> classModel;
  ClassLoaded(this.classModel);
  @override
  // TODO: implement props
  List<Object> get props => [classModel];
}

class ClassLoadFail extends ClassSelectSate{
  String error;
  ClassLoadFail(this.error);

  @override
  List<Object> get props => [error];
}
