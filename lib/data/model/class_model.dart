
import 'package:cloud_firestore/cloud_firestore.dart';

class ClassModel
{
  final String id;
  final String leader;
  final List<String> members;
  final String className;
  final String gradeName;
  final String schoolName;
  final String avatar;
  final Timestamp timeCreate;

  const ClassModel({
        required this.id,
        required this.leader,
        required this.members,
        required this.className,
        required this.gradeName,
        required this.schoolName,
        required this.avatar,
        required this.timeCreate
  });

  Map<String,dynamic> toMap()
  {
    return{
      'id':this.id,
      'leader':this.leader,
      'member':this.members,
      'className':this.className,
      'gradeName':this.gradeName,
      'schoolName':this.schoolName,
      'avatar':this.avatar,
      'timeCreate':this.timeCreate
    };
  }

  static ClassModel formMap(Map<String,dynamic> data)
  {
    return ClassModel(
        id: data["id"] ?? "",
        leader: data["leader"] ??"",
        members: List<String>.from(data["members"]??[]),
        className: data["className"] ?? "",
        gradeName: data["gradeName"] ?? "",
        schoolName: data["schoolName"] ??"",
        avatar: data["avatar"] ??"",
        timeCreate: data['timeCreate']??Timestamp.now());
  }

  ClassModel cloneWith({
    id,
    className,
    leader,
    members,
    gradeName,
    schoolName,
    avatar,
    timeCreate
}){
    return ClassModel(
        id: id ?? this.id,
        leader:  leader ?? this.leader,
        members:  members ?? this.members,
        className: className ?? this.className,
        gradeName: gradeName ?? this.gradeName,
        schoolName: schoolName ?? this.schoolName,
        avatar: avatar ?? this.avatar,
        timeCreate: timeCreate?? this.timeCreate
    );
  }

}