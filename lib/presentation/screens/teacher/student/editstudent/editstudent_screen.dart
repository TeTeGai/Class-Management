import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/screens/teacher/student/editstudent/widget/editstudent_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'bloc/bloc.dart';
class EditStudentScreen extends StatelessWidget {
  final StudentModel studentModel;
  final String sonOrStudent;
  const EditStudentScreen({Key? key, required this.studentModel, required this.sonOrStudent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocProvider(
      create: (context) => EditStudentBloc(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            title:  ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Text('Sửa thông tin lớp',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
            ),
            centerTitle: true,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                color: Colors.grey,
                textColor: Colors.white,
                child: Icon(
                  Icons.close,
                  size: 24,
                ),
                padding: EdgeInsets.only(left: 0),
                shape: CircleBorder(),
              ),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
              reverse: true,

              child: EditStudentForm(studentModel: studentModel,sonOrStudent: sonOrStudent,))
      ),
    );
  }
}

