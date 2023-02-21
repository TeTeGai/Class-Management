import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/gpa/addgpa/gpaadd_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GpaAddScreen extends StatefulWidget {
  final String GoodOrBad;
  const GpaAddScreen({Key? key, required this.GoodOrBad}) : super(key: key);

  @override
  State<GpaAddScreen> createState() => _GpaAddScreenState();
}

class _GpaAddScreenState extends State<GpaAddScreen> {
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
                child: Text('Thêm điểm rèn luyện',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
          resizeToAvoidBottomInset: false,
          body: GpaAddForm(GoodOrBad: widget.GoodOrBad,)
      ),
    );
  }
}
