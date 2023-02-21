import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/main.dart';
import 'package:luan_an/presentation/common_blocs/auth/bloc.dart';
import 'package:luan_an/presentation/screens/login/login/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../utils/dialog.dart';
import 'helper/teddy_controller.dart';
import 'helper/tracking_text_input.dart';



class LoginSceen extends StatefulWidget {
  const LoginSceen({Key? key}) : super(key: key);
  @override
  LoginSceenState createState() => LoginSceenState();
}

class LoginSceenState extends State<LoginSceen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late LoginBloc loginBloc;
  late TeddyController _teddyController;
  String _email = '';
  String _password = '';
  bool _isLoading = false;
  bool _isObscured = true;

  @override
  void initState() {
    loginBloc =  BlocProvider.of<LoginBloc>(context);
    _teddyController = TeddyController();
    super.initState();
  }


  bool get isPopulated =>
      _email.isNotEmpty && _password.isNotEmpty;

  bool isLoginButtonEnabled() {
    return loginBloc.state.isFormValid &&
        !loginBloc.state.isSubmitting &&
        isPopulated;
  }

  void onLogin() {
    if (isLoginButtonEnabled()) {
      loginBloc.add(LoginCredential(
        email: _email,
        password: _password,
      ));
    }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Chưa nhập đủ thông tin", textAlign: TextAlign.center), backgroundColor: Colors.red,
          ),
        );
        _teddyController.play('fail');
      }
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc,LoginState>(
        listener:(context, state) {
          if (state.isSuccess) {
            UtilDialog.hideWaiting(context);
            BlocProvider.of<AuthBloc>(context).add(LoggedIn());
          }

          /// Failure
          if (state.isFailure) {
            UtilDialog.hideWaiting(context);
            _teddyController.play('fail');
            UtilDialog.showInformation(context, content: "Tài khoản hoặc mật khẩu bị sai");
          }

          /// Logging
          if (state.isSubmitting) {
            UtilDialog.showWaiting(context);
          }
        },
        child: BlocBuilder<LoginBloc,LoginState>(
          builder: (context, state) {
            return Container(
              height: 100.h,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.white,
                    Colors.blue,
                  ],
                ),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 8.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SizedBox(
                      height:  25.h,
                      child: FlareActor(
                        "assets/Teddy.flr",
                        shouldClip: false,
                        alignment: Alignment.bottomCenter,
                        fit: BoxFit.contain,
                        controller: _teddyController,
                      ),
                    ),
                    Container(
                      height: 45.h,
                      margin: const EdgeInsets.symmetric(horizontal: 15.0),
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      child: Form(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            TrackingTextInput(
                              onTextChanged: (String email) {
                                _email = email;
                              },
                              label: "Email",
                              onCaretMoved: (Offset caret) {
                                _teddyController.coverEyes(false);
                                _teddyController.lookAt(caret);
                              },
                              icon: Icons.email,
                              enable: !_isLoading,
                            ),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Expanded(
                                  child: TrackingTextInput(
                                    label: "Mật khẩu",
                                    isObscured: _isObscured,
                                    onCaretMoved: (Offset caret) {
                                      _teddyController.coverEyes(true);
                                      _teddyController.lookAt(null);
                                    },
                                    onTextChanged: (String password) {
                                      _password = password;
                                    },
                                    icon: Icons.lock,
                                    enable: !_isLoading,
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility,
                                      color: Colors.black45),
                                  onPressed: () {
                                    setState(() {
                                      _isObscured = !_isObscured;
                                    });
                                  },
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: onLogin,
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
                                ),
                                padding:
                                MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 8)),
                                backgroundColor: MaterialStateProperty.all(Colors.deepOrange.shade600),
                              ),
                              child: _isLoading
                                  ? const SpinKitThreeBounce(
                                color: Colors.white,
                                size: 25.0,
                              )
                                  : const Text(
                                'Đăng nhập',
                                style: TextStyle(
                                  fontFamily: 'Nunito',
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(onPressed: (){
                               Navigator.of(context).pushNamed(AppRouter.ROLESELECT);
                            }, child: Text("Bạn chưa có tài khoản?",style: TextStyle(fontSize: 15.sp,color: Colors.deepOrange),)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },

        ),
      );
  }


}