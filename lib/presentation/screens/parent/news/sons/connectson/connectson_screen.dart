import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/repository/repository.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/connectson/bloc/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../data/model/student_model.dart';
import '../../../../../../utils/snackbar.dart';
class ConnectSonScreen extends StatefulWidget {
  final StudentModel studentModel;
  const ConnectSonScreen({Key? key, required this.studentModel, }) : super(key: key);

  @override
  State<ConnectSonScreen> createState() => _ConnectSonScreenState();
}

class _ConnectSonScreenState extends State<ConnectSonScreen> {
  TextEditingController classIdController = new TextEditingController();
  // UserAuthRepository userAuthRepository = new UserAuthRepository();
  // late String nameUser;
  // late String phoneUser;
  // @override
  // void initState() {
  //   userAuthRepository.getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
  //     nameUser = value.firstName+ " "+ value.lastName;
  //     phoneUser = value.phoneNumber;
  //   });
  //   // TODO: implement initState
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text("Kết nối với lớp",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
      ),
      body: Column(
        children: [
          SizedBox(height: 2.h,),
          Center(child: Text("Nhập mã tham gia vào lớp của con bạn",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400),)),
          SizedBox(height: 2.h,),
          Container(
            width: 85.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: classIdController,
                  onChanged: (value) {
                    // signUpBloc.add(EmailChange(email: value));
                  },
                  validator: (_) {
                    // return !signUpBloc.state.isEmailValid ? "Email chưa hợp lệ" :null;
                  },
                  autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Mã tham gia",
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade400)
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.teal)
                    ),

                  ),
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: EdgeInsets.only(top: 3, left: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )
              ),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: () {
                  if(classIdController.text.isEmpty)
                    {
                      MySnackBar.error(message: "Vui lòng nhập mã tham gia lớp", color: Colors.red, context: context);
                    }
                  else{
                    ConnectSonBloc()..add(Submit(classIdController.text,widget.studentModel.id,context));
                  }
                },
                color: Colors.greenAccent,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Đăng ký", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18
                ),),
              ),
            ),
          )
        ],
      ),
    );  }
}

