import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/class/add/screen/addparent/widget/addparent_form.dart';
import 'package:luan_an/presentation/screens/teacher/class/add/screen/addparent/widget/addparent_header.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
class AddParentScreen extends StatelessWidget {
  final ClassModel classModel;
  const AddParentScreen({Key? key, required this.classModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 2.h,),
            Center(child: Text("Danh sách học sinh",style: TextStyle(fontSize: 20.sp),)),
            SizedBox(height: 2.h,),
            AddParentHeader(classModel: classModel),
            AddParentForm(),
          ],
        )
    );
  }
}
