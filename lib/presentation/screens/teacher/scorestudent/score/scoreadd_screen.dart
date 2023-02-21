import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/score/addscore/scoreadd_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ScoreAddScreen extends StatefulWidget {
  const ScoreAddScreen({Key? key}) : super(key: key);

  @override
  State<ScoreAddScreen> createState() => _ScoreAddScreenState();
}

class _ScoreAddScreenState extends State<ScoreAddScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreBloc(),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            title:  ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Text('Thêm điểm môn học',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
          body: SingleChildScrollView(
              reverse: true,
              child: ScoreAddForm())
      ),
    );
  }
}
