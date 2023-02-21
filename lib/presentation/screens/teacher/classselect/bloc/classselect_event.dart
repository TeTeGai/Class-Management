import 'package:equatable/equatable.dart';
import 'package:luan_an/data/model/class_model.dart';


abstract class ClassSelectEvent extends Equatable{
  const ClassSelectEvent();
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
class ClassLoad extends ClassSelectEvent {}
class ClassUpdate extends ClassSelectEvent{
  List<ClassModel> classModel;
  ClassUpdate(this.classModel);
  @override
  // TODO: implement props
  List<Object?> get props => [classModel];
}
