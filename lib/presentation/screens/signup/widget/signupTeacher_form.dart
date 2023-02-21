import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luan_an/configs/dropdown.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/presentation/screens/signup/signup/bloc.dart';
import 'package:luan_an/utils/dialog.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';
import '../../../../data/model/gpa_model.dart';
import '../../../../utils/snackbar.dart';
import '../helper/FadeAnimation.dart';

class SignUpTeacherForm extends StatefulWidget {
  final bool teacher;
  const SignUpTeacherForm({Key? key, required this.teacher}) : super(key: key);

  @override
  State<SignUpTeacherForm> createState() => _SignUpTeacherFormState();
}


class _SignUpTeacherFormState extends State<SignUpTeacherForm> {
  get isTeacher => widget.teacher == true;
  late SignUpBloc signUpBloc;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  late String phoneComplete;
  String selectedValue = "Ông";
  String selectedValue2 = "Thầy";
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;
  @override
  void initState() {
    signUpBloc= BlocProvider.of<SignUpBloc>(context);
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    firstNameController.dispose();
    lastnameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  bool get isPopulated =>
      emailController.text.isNotEmpty && firstNameController.text.isNotEmpty&&
      lastnameController.text.isNotEmpty && passwordController.text.isNotEmpty&&
      confirmPasswordController.text.isNotEmpty &&
          phoneController.text.isNotEmpty;
  bool isSignUpButtonEnabled()
  {
    return signUpBloc.state.isFormValid && !signUpBloc.state.isSubmitting
        && isPopulated;
  }


  void onRegister() {
    if(isTeacher)
      {
        if (isSignUpButtonEnabled()) {
          if(selectedValue2 == "Thầy")
            {
              UserModel newUser = UserModel(
                email: emailController.text,
                firstName: firstNameController.text,
                lastName: lastnameController.text,
                phoneNumber: phoneComplete,
                id: emailController.text,
                avatar: "https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Favatar%2FAvatarNam-Facebook-tr%E1%BA%AFng.jpg?alt=media&token=39ce0926-8030-4e9c-aabe-234c559dca1d",
                sex: selectedValue2.toString(),
                role: "teacher",
                  pushToken:"",
              );
              UserModel initalUser = newUser.cloneWith(email:newUser.email);
              signUpBloc.add(
                Submitted(
                  newUser: initalUser,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                ),
              );
            }
          else
            {
              UserModel newUser = UserModel(
                email: emailController.text,
                firstName: firstNameController.text,
                lastName: lastnameController.text,
                phoneNumber: phoneComplete,
                id: emailController.text,
                avatar: "https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Favatar%2F%E1%BA%A2nh-%C4%91%E1%BA%A1i-di%E1%BB%87n-FB-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-n%E1%BB%AF.jpg?alt=media&token=79afca9f-f64a-4cb5-b468-a9fa27a60525",
                sex: selectedValue2.toString(),
                role: "teacher",
                  pushToken:""
              );
              UserModel initalUser = newUser.cloneWith(email:newUser.email);
              signUpBloc.add(
                Submitted(
                  newUser: initalUser,
                  password: passwordController.text,
                  confirmPassword: confirmPasswordController.text,
                ),
              );
            }
        }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Chưa nhập đủ thông tin", textAlign: TextAlign.center), backgroundColor: Colors.red,
              ),
            );
          }
      }
    else
      {
        if (isSignUpButtonEnabled()) {
          if(selectedValue == "Ông")
          {
            UserModel newUser = UserModel(
                email: emailController.text,
                firstName: firstNameController.text,
                lastName: lastnameController.text,
                phoneNumber: phoneComplete,
                id: emailController.text,
                avatar: "https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Favatar%2FAvatarNam-Facebook-tr%E1%BA%AFng.jpg?alt=media&token=39ce0926-8030-4e9c-aabe-234c559dca1d",
                sex: selectedValue.toString(),
                role: "parent",
                pushToken:""
            );
            UserModel initalUser = newUser.cloneWith(email:newUser.email);
            signUpBloc.add(
              Submitted(
                newUser: initalUser,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
              ),
            );
          }
          else
          {
            UserModel newUser = UserModel(
                email: emailController.text,
                firstName: firstNameController.text,
                lastName: lastnameController.text,
                phoneNumber: phoneComplete,
                id: emailController.text,
                avatar: "https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Favatar%2F%E1%BA%A2nh-%C4%91%E1%BA%A1i-di%E1%BB%87n-FB-m%E1%BA%B7c-%C4%91%E1%BB%8Bnh-n%E1%BB%AF.jpg?alt=media&token=79afca9f-f64a-4cb5-b468-a9fa27a60525",
                sex: selectedValue2.toString(),
                role: "parent",
                pushToken:""
            );
            UserModel initalUser = newUser.cloneWith(email:newUser.email);
            signUpBloc.add(
              Submitted(
                newUser: initalUser,
                password: passwordController.text,
                confirmPassword: confirmPasswordController.text,
              ),
            );
          }
        }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Chưa nhập đủ thông tin", textAlign: TextAlign.center), backgroundColor: Colors.red,
              ),
            );
          }
        }

  }
  @override
  Widget build(BuildContext context) {
    return  BlocListener<SignUpBloc,SignUpState>(
          listener: (context, state) {
            if(state.isSuccess)
              {
                UtilDialog.hideWaiting(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Đăng ký thành công", textAlign: TextAlign.center), backgroundColor: Colors.blue,
                  ),
                );

                Navigator.popUntil(context, (Route<dynamic> predicate) => predicate.isFirst);

              }
            if(state.isFailure)
              {
                UtilDialog.hideWaiting(context);
                UtilDialog.showInformation(context,content: 'Email này đã được đăng ký');
              }
            if(state.isSubmitting)
              {
                UtilDialog.showWaiting(context);
              }
          },
        child: BlocBuilder<SignUpBloc,SignUpState>(
          builder: (context, state)
          {
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 30,),
                  height: MediaQuery.of(context).size.height - 140,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            FadeAnimation(1, Text("Đăng ký", style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold
                            ),)),
                            SizedBox(height: 10,),
                            if(isTeacher) ...[
                              FadeAnimation(1.2, Text("Tạo một tài khoản giáo viên", style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700]
                              ),)),
                            ]
                            else ...[
                              FadeAnimation(1.2, Text("Tạo một tài khoản phụ huynh", style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey[700]
                              ),)),
                            ],

                          ],
                        ),
                        Column(
                          children: [
                            if(isTeacher) ...[
                              FadeAnimation(1.2, dropDown2(["Thầy","Cô"])),
                            ]
                            else ...[
                              FadeAnimation(1.2, dropDown(["Ông","Bà"])),
                            ],
                            FadeAnimation(1.3, firstNameInput(label: "Họ")),
                            FadeAnimation(1.4, lastNameInput(label: "Tên")),
                            FadeAnimation(1.5, phoneInput()),
                            FadeAnimation(1.5, emailInput(label: "Email")),
                            FadeAnimation(1.6, passwordInput(label: "Mật khẩu")),
                            FadeAnimation(1.7, confirmPasswordInput(label: "Nhập lại mật khẩu")),
                          ],
                        ),
                        FadeAnimation(1.7, Container(
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
                            onPressed: () async {

                              // await FirebaseAuth.instance.verifyPhoneNumber(
                              //   phoneNumber: phoneComplete,
                              //   verificationCompleted: (PhoneAuthCredential credential) {
                              //     print("Hoan thanh");
                              //   },
                              //   verificationFailed: (FirebaseAuthException e) {
                              //     MySnackBar.error(message: "Mật khẩu không đúng", color: Colors.red, context: context);
                              //
                              //   },
                              //   codeSent: (String verificationId, int? resendToken) {
                              //     Navigator.of(context).pushNamed(AppRouter.VERIFY,arguments:verificationId );
                              //   },
                              //   codeAutoRetrievalTimeout: (String verificationId) {},
                              // );
                              onRegister();
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
                        )),

                      ],
                    ),
                  ),
                ),
            //   ),

            );
          },
        ),
      );
  }
  Widget phoneInput()
  {
    return IntlPhoneField(
      controller: phoneController,
      keyboardType:
      TextInputType.numberWithOptions(signed: true, decimal: true),
      decoration: InputDecoration(
        labelText: 'Số điện thoại',
        border: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
      ),
      initialCountryCode: 'VN',
      onChanged: (phone) {
        print(phone.completeNumber);
        setState(() {
          phoneComplete = phone.completeNumber;
        });
      },
    );
  }
  Widget firstNameInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: firstNameController,
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
  Widget lastNameInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: lastnameController,
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
  Widget emailInput({label, obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: emailController,
          onChanged: (value) {
            signUpBloc.add(EmailChange(email: value));
          },
          validator: (_) {
            return !signUpBloc.state.isEmailValid ? "Email chưa hợp lệ" :null;
          },
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.emailAddress,
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
  Widget passwordInput({label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          controller: passwordController,
          onChanged: (value) {
            signUpBloc.add(PasswordChange(password: value));
          },
          validator: (_) {
            return !signUpBloc.state.isPasswordValid ? "Mật khẩu phải ít nhất 8 ký tự gồm chữ, số,ký tự đặc biệt" :null;
          },
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.text,
          obscureText: !isShowPassword,
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
              icon: isShowPassword
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
          controller: confirmPasswordController,
          onChanged: (value) {
            signUpBloc.add(ConfirmPasswordChange(confirmPassword: value,password: passwordController.text));
          },
          validator: (_) {
            return !signUpBloc.state.isConfirmPasswordValid ? "Mật khẩu nhập lại không đúng" :null;
          },
          autovalidateMode: AutovalidateMode.always,
          keyboardType: TextInputType.text,
          obscureText: !isShowConfirmPassword,
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
              icon: isShowConfirmPassword
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


  Widget dropDown(List<String> item) {
    late List<String> items = item;
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField2(
              value: selectedValue,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)
                ),
              ),
              isExpanded: true,
              hint:  Text(
                items.first,
                style: TextStyle(fontSize: 14),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonWidth: 200.h,
              buttonPadding: const EdgeInsets.only(left: 10, right: 10),
              items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Vui lòng chọn giới tính';
                }
              },
              onChanged: (value) {
                selectedValue = value.toString();
                setState(() {
                  selectedValue;
                  print(selectedValue);
                });

              },
              onSaved: (value) {
                setState(() {
                  selectedValue = value.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget dropDown2(List<String> item) {
    late List<String> items = item;
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButtonFormField2(
              value: selectedValue2,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey.shade400)
                ),
              ),
              isExpanded: true,
              hint:  Text(
                items.first,
                style: TextStyle(fontSize: 14),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
              iconSize: 30,
              buttonHeight: 50,
              buttonWidth: 200.h,
              buttonPadding: const EdgeInsets.only(left: 10, right: 10),
              items: items
                  .map((item) =>
                  DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Vui lòng chọn giới tính';
                }
              },
              onChanged: (value) {
                selectedValue2 = value.toString();
                setState(() {
                  selectedValue2;
                  print(selectedValue2);
                });

              },
              onSaved: (value) {
                setState(() {
                  selectedValue2 = value.toString();
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

