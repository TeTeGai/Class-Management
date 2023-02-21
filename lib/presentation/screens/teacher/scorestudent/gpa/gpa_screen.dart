import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/gpa/widget/gpabad_form.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/gpa/widget/gpagood_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../data/model/user_model.dart';
import '../../../../../data/repository/user_repository/firebase_user_repo.dart';
class GpaScreen extends StatefulWidget {
  final StudentModel studentModel;
  const GpaScreen({Key? key, required this.studentModel}) : super(key: key);

  @override
  State<GpaScreen> createState() => _GpaScreenState();
}

class _GpaScreenState extends State<GpaScreen> {
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  String pushToken ="";
  @override
  void initState() {
    if(widget.studentModel.isConnect)
      {
        userAuthRepository.getUserByID(widget.studentModel.idParent).then((value)
        {
          setState(() {
            pushToken = value.pushToken;
          });
        });
      }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScoreBloc>(create: (context) => ScoreBloc()..add(GPAGoodLoad())..add(GPABadLoad()),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              GpaGoodForm(studentModel: widget.studentModel,pushToken: pushToken),

              GpaBadForm(studentModel: widget.studentModel,pushToken: pushToken),
            ],
          ),
        ));
  }
}
