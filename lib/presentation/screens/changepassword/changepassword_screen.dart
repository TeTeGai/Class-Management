import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/screens/changepassword/bloc/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/snackbar.dart';

class ChangePassWord extends StatefulWidget {
  const ChangePassWord({Key? key}) : super(key: key);

  @override
  State<ChangePassWord> createState() => _ChangePassWordState();
}

class _ChangePassWordState extends State<ChangePassWord> {
  bool isShowOldPassword = true;
  bool isShowPassword = true;
  bool isShowConfirmPassword = true;
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmNewPasswordController = TextEditingController();
  late ChangePassWordBloc changePassWordBloc;
  bool get isPopulated =>
      oldPasswordController.text.isNotEmpty && newPasswordController.text.isNotEmpty&&
          confirmNewPasswordController.text.isNotEmpty;
  bool isChangeButtonEnabled()
  {
    return changePassWordBloc.state.isFormValid && !changePassWordBloc.state.isSubmitting
        && isPopulated;
  }
  void onChange()
  {
    if (isChangeButtonEnabled()) {
      try{
        if(oldPasswordController.text.trim() != newPasswordController.text.trim())
          {
            changePassWordBloc.add(
                Submitted(
                    oldPassword: oldPasswordController.text.trim(),
                    password: newPasswordController.text.trim(),
                    confirmPassword: confirmNewPasswordController.text.trim(),
                    contex: context)
            );
          }
        else
          {
            MySnackBar.error(message: "Mật khẩu mới không được trùng với mật khẩu cũ", color: Colors.red, context: context);

          }

      }
      catch(e)
    {
      MySnackBar.error(message: "Mật khẩu cũ không đúng", color: Colors.red, context: context);

    }

    }
    else{
      MySnackBar.error(message: "Có gì đó sai sai", color: Colors.red, context: context);
    }

  }
  @override
  void initState() {
    changePassWordBloc= BlocProvider.of<ChangePassWordBloc>(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Colors.white,
        elevation: 0,
        brightness: Brightness.light,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0,top: 8,bottom: 8),
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
        ],
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 2.h,),
              Row(
                children: [
                  Text("Thay đổi mật khẩu",style: TextStyle(fontSize: 22.sp,fontWeight: FontWeight.w400,)),
                ],
              ),
              SizedBox(height: 3.h,),
              oldPasswordInput(label: "Mật khẩu cũ"),
              passwordInput(label:  "Mật khẩu mới"),
              confirmPasswordInput(label: "Xác nhận mật khẩu mới"),
              SizedBox(width: 60.w,
              child: Text("Mật khẩu phải bao gồm ít nhất 8 kí tự, bao gồm chữ, số và 1 kí tự đặc biệt",
                  style: TextStyle(fontSize: 15.sp,color: Colors.grey),textAlign: TextAlign.center),),
              SizedBox(height: 2.h,),
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
                    onChange();
                    },
                  color: Colors.cyan,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: Text("Đổi mật khẩu", style: TextStyle(
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
    );
  }
  Widget oldPasswordInput({label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: oldPasswordController,
          onChanged: (value) {
            changePassWordBloc.add(OldPasswordChange(OldPassword: value));
          },
          validator: (_) {
            // return !changePassWordBloc.state.isOldPasswordValid ? "Mật khẩu phải ít nhất 8 ký tự gồm chữ, số,ký tự đặc biệt" :null;
          },
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.text,
          obscureText: isShowOldPassword,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal),
            ),
            suffixIcon: IconButton(
              icon: !isShowOldPassword
                  ? Icon(Icons.visibility_outlined)
                  : Icon(Icons.visibility_off_outlined),
              onPressed: () {
                setState(() {
                  isShowOldPassword = !isShowOldPassword;
                });
              },

            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
  Widget passwordInput({label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: newPasswordController,
          onChanged: (value) {
            changePassWordBloc.add(NewPasswordChange(NewPassword: value));
          },
          validator: (_) {
            return !changePassWordBloc.state.isNewPasswordValid ? "Mật khẩu phải ít nhất 8 ký tự gồm chữ, số,ký tự đặc biệt" :null;
          },
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.text,
          obscureText: isShowPassword,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)
            ),
            suffixIcon: IconButton(
              icon: !isShowPassword
                  ? Icon(Icons.visibility_outlined)
                  : Icon(Icons.visibility_off_outlined),
              onPressed: () {
                setState(() {
                  isShowPassword = !isShowPassword;
                });
              },

            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
  Widget confirmPasswordInput({label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: confirmNewPasswordController,
          onChanged: (value) {
            changePassWordBloc.add(ConfirmNewPasswordChange(ConfirmNewPassword: value,NewPassword: newPasswordController.text ));
          },
          validator: (_) {
            return !changePassWordBloc.state.isConfirmNewPasswordValid ? "Mật khẩu nhập lại không đúng" :null;
          },
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.text,
          obscureText: isShowConfirmPassword,
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade400)
            ),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.teal)
            ),
            suffixIcon: IconButton(
              icon: !isShowConfirmPassword
                  ? Icon(Icons.visibility_outlined)
                  : Icon(Icons.visibility_off_outlined),
              onPressed: () {
                setState(() {
                  isShowConfirmPassword = !isShowConfirmPassword;
                });
              },

            ),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
}
