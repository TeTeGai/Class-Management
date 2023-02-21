
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/presentation/screens/signup/signup/bloc.dart';
import '../../../data/model/user_model.dart';
import 'widget/signupTeacher_form.dart';

class SignUpTeacherScreen extends StatelessWidget {
  final bool teacher;

  const SignUpTeacherScreen({Key? key, required this.teacher}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpBloc(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
            ),
          ),
          body: SingleChildScrollView(
            reverse: true,
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                SignUpTeacherForm( teacher: this.teacher,),
              ],
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Bạn đã có tài khoản?",style: TextStyle(color: Colors.grey,fontSize: 15),),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(AppRouter.LOGIN,(route) => false,);
                    },
                    child: Text("Đăng nhập",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)))
              ],
            ),
            elevation: 0,
          ),
        ),
      ),
    );
  }
}