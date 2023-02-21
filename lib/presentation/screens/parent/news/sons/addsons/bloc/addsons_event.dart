import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/student_model.dart';

class AddSonsEvent extends Equatable{
  const AddSonsEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AddSons extends AddSonsEvent{
  StudentModel studentModel;
   Uint8List? file;
   String? img;
  AddSons(this.studentModel,this.file,this.img);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}