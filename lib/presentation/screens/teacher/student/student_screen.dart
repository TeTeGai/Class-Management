import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:luan_an/presentation/common_blocs/student/student_bloc.dart';
import 'package:luan_an/presentation/screens/teacher/student/widget/studentwidget.dart';

class StudentScreen extends StatefulWidget {
  final ClassModel classModel;
  const StudentScreen({Key? key, required this.classModel}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(),
      child: SingleChildScrollView(child: StudentWidget(classModel: widget.classModel,))

    );
  }
}
