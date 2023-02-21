import 'dart:typed_data';

import 'package:equatable/equatable.dart';

import '../../../../../../data/model/class_model.dart';



class EditClassEvent extends Equatable{
  const EditClassEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ClassChange extends EditClassEvent{
  final String clas;
  ClassChange(this.clas);
  @override
  // TODO: implement props
  List<Object?> get props => [this.clas];
}
class GradeChange extends EditClassEvent{
  final String grade;
  GradeChange(this.grade);
  @override
  // TODO: implement props
  List<Object?> get props => [this.grade];
}
class SchoolChange extends EditClassEvent{
  final String school;
  SchoolChange(this.school);
  @override
  // TODO: implement props
  List<Object?> get props => [this.school];
}

class Submit extends EditClassEvent{
  final ClassModel classModel;
  final Uint8List? file;
  final String? img;
  Submit(this.classModel,this.file,this.img);
  @override
  // TODO: implement props
  List<Object?> get props => [classModel,file];
}

