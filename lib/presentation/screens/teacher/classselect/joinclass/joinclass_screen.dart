import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/joinclass/bloc/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/dialog.dart';
import '../../../../../utils/snackbar.dart';
class JoinClassScreen extends StatelessWidget {
   JoinClassScreen({Key? key}) : super(key: key);

   TextEditingController classIdController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        centerTitle: true,
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text("Tham gia lớp",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
        ),
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
      body: BlocProvider(
        create: (context) => JoinClassBloc(),
        child: BlocListener<JoinClassBloc,JoinClassState> (
          listener:(context, state) {
            if (state.isSuccess) {
              UtilDialog.hideWaiting(context);
              Navigator.of(context).pop();
            }

            /// Failure
            if (state.isFailure) {
              UtilDialog.hideWaiting(context);
              UtilDialog.showInformation(context, content: "Tài khoản hoặc mật khẩu bị sai");
            }

            /// Logging
            if (state.isSubmitting) {
              UtilDialog.showWaiting(context);
            }
          },
          child: BlocBuilder<JoinClassBloc,JoinClassState>(
            builder: (context, state) =>
            Column(
              children: [
                Center(child: Text("Nhập mã tham gia lớp",style: TextStyle(fontSize: 20.sp),),),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: classIdInput(label: "Mã tham gia lớp"),
                ),
                Container(
                  width: 85.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black54),
                        top: BorderSide(color: Colors.black54),
                        left: BorderSide(color: Colors.black54),
                        right: BorderSide(color: Colors.black54),
                      )
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 50,
                    onPressed: () {
                      if(classIdController.text.isNotEmpty)
                        {
                          JoinClassBloc()..add(Submit(classIdController.text, context));
                        }
                      else
                        {
                          MySnackBar.error(message: "Vui lòng nhập mã lớp" , color: Colors.red, context: context);
                        }

                    },
                    color: Colors.cyan,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Kiểm tra", style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                        color: Colors.white
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget classIdInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: classIdController,
          obscureText: obscureText,
          decoration: InputDecoration(
            labelText: label,
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
    );
  }
}
