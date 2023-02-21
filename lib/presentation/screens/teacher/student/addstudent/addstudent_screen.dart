import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/screens/teacher/student/addstudent/widget/addstudent_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../common_blocs/student/bloc.dart';
import 'widget/addstudent_header.dart';


class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({Key? key}) : super(key: key);

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
          title:  ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Thêm học sinh mới',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
          ),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.pop(context,true);
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
        // resizeToAvoidBottomInset: true,
        body: Column
          (
          children: [
            AddStudentHeader(),
            Expanded(child: AddStudentForm())

          ],
        )

        )
    );
  }
}
