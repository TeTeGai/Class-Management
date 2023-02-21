import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/request_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';

class StudentEvent extends Equatable{
  const StudentEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class AddStudent extends StudentEvent{
  final String name;
  const AddStudent(this.name);
  @override
  // TODO: implement props
  List<Object?> get props => [name];
}

class AddRollCall extends StudentEvent{
  final String name;
  final String time;
  final int rollCall;
  const AddRollCall(this.name,this.time,this.rollCall);
  @override
  // TODO: implement props
  List<Object?> get props => [name,time,rollCall];
}
class RemoveStudent extends StudentEvent{
  final String idStudent;
  const RemoveStudent(this.idStudent);
  @override
  // TODO: implement props
  List<Object?> get props => [idStudent];
}

class RemoveSon extends StudentEvent{
  final String idSon;
  const RemoveSon(this.idSon);
  @override
  // TODO: implement props
  List<Object?> get props => [idSon];
}

class AddRequest extends StudentEvent{
  final String title;
  final String content;
  final String img;
  final String classId;
  final String studentId;
  final String name;
  const AddRequest(this.title,this.content,this.img,this.classId,this.studentId,this.name);
  @override
  // TODO: implement props
  List<Object?> get props => [title,content,img,classId,studentId,name];
}
class RemoveRequest extends StudentEvent{
  final String classId;
  final String requestId;

  const RemoveRequest(this.classId,this.requestId);
  @override
  // TODO: implement props
  List<Object?> get props => [classId,requestId];
}
class LoadStudent extends StudentEvent{
}
class LoadTeacherUser extends StudentEvent{
}
class LoadStudentParent extends StudentEvent{
}
class LoadStudentNoParent extends StudentEvent{
}
class LoadSons extends StudentEvent{
}
class LoadRequest extends StudentEvent{
  final String? classId;
  final String studentId;
  LoadRequest(this.classId,this.studentId);
  @override
  // TODO: implement props
  List<Object?> get props => [classId,studentId];
}
class LoadClassRequest extends StudentEvent{
  final String studentId;
  LoadClassRequest(this.studentId);
  @override
  // TODO: implement props
  List<Object?> get props => [studentId];
}
class UpdateStudent extends StudentEvent{
  final List<StudentModel> studentModel;
  UpdateStudent(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
class UpdateStudentParent extends StudentEvent{
  final List<StudentModel> studentModel;
  UpdateStudentParent(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
class UpdateStudentNoParent extends StudentEvent{
  final List<StudentModel> studentModel;
  UpdateStudentNoParent(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
class UpdateTeacherUser extends StudentEvent{
  final List<UserModel> usermodel;
  UpdateTeacherUser(this.usermodel);
  @override
  // TODO: implement props
  List<Object?> get props => [usermodel];
}

class UpdateSons extends StudentEvent{
  final List<StudentModel> studentModel;
  UpdateSons(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
class UpdateRequest extends StudentEvent{
  final List<RequestModel> requestModel;
  UpdateRequest(this.requestModel);
  @override
  // TODO: implement props
  List<Object?> get props => [requestModel];
}
class UpdateModelRequest extends StudentEvent{
  String requestId;
  String idParent;
  String title;
  UpdateModelRequest(this.requestId,this.idParent,this.title);
  @override
  // TODO: implement props
  List<Object?> get props => [requestId,idParent,title];
}