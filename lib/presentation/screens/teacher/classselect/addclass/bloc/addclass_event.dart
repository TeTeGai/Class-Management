import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../../../../data/model/class_model.dart';



class AddClassEvent extends Equatable{
  const AddClassEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ClassChange extends AddClassEvent{
  final String clas;
  ClassChange(this.clas);
  @override
  // TODO: implement props
  List<Object?> get props => [this.clas];
}
class GradeChange extends AddClassEvent{
  final String grade;
  GradeChange(this.grade);
  @override
  // TODO: implement props
  List<Object?> get props => [this.grade];
}
class SchoolChange extends AddClassEvent{
  final String school;
  SchoolChange(this.school);
  @override
  // TODO: implement props
  List<Object?> get props => [this.school];
}

class Submit extends AddClassEvent{
  final ClassModel classModel;
  final Uint8List? file;
  final String? img;
  Submit(this.classModel,this.file,this.img);
  @override
  // TODO: implement props
  List<Object?> get props => [classModel,file];
}

