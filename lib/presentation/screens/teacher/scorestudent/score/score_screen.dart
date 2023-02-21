import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/score/widget/score_form.dart';

import '../../../../../data/model/student_model.dart';
import '../../../../../data/repository/user_repository/firebase_user_repo.dart';

class ScoreScreen extends StatefulWidget {
  final StudentModel studentModel;
  const ScoreScreen({Key? key, required this.studentModel}) : super(key: key);

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
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
    return BlocProvider(create: (context) => ScoreBloc()..add(ScoreLoad()),
    child: Scaffold(
      resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(child: ScoreForm(studentModel: widget.studentModel,pushToken:pushToken ),) ),);
  }
}
