import 'package:flutter/material.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/statistic/score_statistic/score_statistic.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'gpa_statistic/gpa_statistic_screen.dart';

class StatisticScreen extends StatefulWidget {
  final StudentModel studentModel;

  const StatisticScreen({Key? key, required this.studentModel,}) : super(key: key);

  @override
  State<StatisticScreen> createState() => _StatisticScreenScreenState();
}

class _StatisticScreenScreenState extends State<StatisticScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
              title:  ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text(widget.studentModel.name,  maxLines: 4,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
              ),
              centerTitle: true,
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
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
              bottom: TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text("Rèn luyện",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),

                    ),
                    Tab(
                      child: Text("Điểm số",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),
                    ),
                  ]),
            ),
            resizeToAvoidBottomInset: false,
            body: TabBarView(
              children: [
                GpaStatisticScreen(studentModel: widget.studentModel),
                ScoreStatisticScreen(studentModel: widget.studentModel)
              ],
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
