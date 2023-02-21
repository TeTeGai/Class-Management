import 'package:flutter/material.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'gpason_homestatistic/gpason_statistic_screen.dart';
import 'gpason_statistic/gpason_statistic_screen.dart';



class StatisticSonScreen extends StatefulWidget {
  final StudentModel studentModel;

  const StatisticSonScreen({Key? key, required this.studentModel,}) : super(key: key);

  @override
  State<StatisticSonScreen> createState() => _StatisticSonScreenScreenState();
}

class _StatisticSonScreenScreenState extends State<StatisticSonScreen> {
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
                      child: Text("Ở lớp",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),
                    ),
                    Tab(
                      child: Text("Ở nhà",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),
                    ),
                  ]),
            ),
            resizeToAvoidBottomInset: false,
            body: TabBarView(
              children: [
                GpaSonStatisticScreen(studentModel: widget.studentModel),
                GpaSonHomeStatisticScreen(studentModel: widget.studentModel)
              ],
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
