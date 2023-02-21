import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/request_model.dart';
import 'package:luan_an/data/model/request_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import '../../../data/model/user_model.dart';

class StudentState extends Equatable{
  const StudentState();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class LoadingStudent extends StudentState{}

class LoadedStudent extends StudentState{
  final List<StudentModel> studentModel;
  LoadedStudent(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}

class LoadedSons extends StudentState{
  final List<StudentModel> studentModel;
  LoadedSons(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
class LoadedStudentNoParent extends StudentState{
  final List<StudentModel> studentModel;
  LoadedStudentNoParent(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
class LoadedTeacherUser extends StudentState{
  final List<UserModel> usermodel;
  LoadedTeacherUser(this.usermodel);
  @override
  // TODO: implement props
  List<Object?> get props => [usermodel];
}
class LoadedStudentParent extends StudentState{
  final List<StudentModel> studentModel;
  LoadedStudentParent(this.studentModel);
  @override
  // TODO: implement props
  List<Object?> get props => [studentModel];
}
class LoadedRequest extends StudentState{
  final List<RequestModel> requestModel;
  LoadedRequest(this.requestModel);
  @override
  // TODO: implement props
  List<Object?> get props => [requestModel];
}
class LoadFailStudent extends StudentState{
  final String error;
  const LoadFailStudent(this.error);
  @override
  String toString() {
    print(error.toString());

    return super.toString();
  }
}
