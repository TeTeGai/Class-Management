import 'package:flutter/material.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../configs/router.dart';


class ClassWidget extends StatelessWidget {
  final ClassModel classModel;
  const ClassWidget({Key? key, required this.classModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.only(left: 10,top: 10),
        child: TextButton(
          onPressed: () async{
            Navigator.pushNamed(context, AppRouter.HOMETEACHER,arguments: classModel);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('classId', classModel.id);
          },
          child:  Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start ,
          children: [
            CircleAvatar(radius: 22.sp,
              backgroundImage: NetworkImage(classModel.avatar),
              backgroundColor: Colors.teal.shade700,
            ),
            SizedBox(width: 10,),
            Text(classModel.className,style: TextStyle(fontSize: 17.sp,color: Colors.black)),
          ],
        ),)
    );
    return      Text(classModel.schoolName,style: TextStyle(fontSize: 17.sp));
  }
}
