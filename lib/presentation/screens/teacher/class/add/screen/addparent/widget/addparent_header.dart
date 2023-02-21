import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../../../utils/snackbar.dart';
class AddParentHeader extends StatefulWidget {
  final ClassModel classModel;
  const AddParentHeader({Key? key, required this.classModel}) : super(key: key);

  @override
  State<AddParentHeader> createState() => _AddParentHeaderState();
}

class _AddParentHeaderState extends State<AddParentHeader> {


  late String nameUser;
  TextEditingController emailController = new TextEditingController();
  @override
  void initState() {
    UserAuthRepository().getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
      nameUser = value.firstName + " " + value.lastName ;
    });
    super.initState();
  }

  bool hasSentMail = false;


  void Mailer(String className,String schoolName,String classId,String nameUser,String nameStudent) async {
    if(isButtonEnabled())
    {
      String username = 'thanh31ntt@gmail.com';
      String password = 'fmeylulfehaxzcql';

      final smtpServer = gmail(username, password);

      //Create our Message
      final message = Message()
        ..from = Address(username, 'Class App Mail')
        ..recipients.add(emailController.text)
        ..subject = 'Class App Mailer';
      var nameFromSomeInput = username;
      var yourHtmlTemplate = '''
        <!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
    table,
    td,
    div,
    h1,
    p {
        font-family: Arial, sans-serif;
    }

    table,
    td {
        border: none;
    }
    </style>
</head>

<body style="margin:0;padding:0;">
    <table role="presentation"
        style="width:602px;border-collapse:collapse;border:1px solid #cccccc;border-spacing:0;text-align:left;">
        <tr>
            <td align="center" style="background:#107F8A">
                <img src="https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Fic_launcher_adaptive_fore.png?alt=media&token=c4dea057-42a3-4217-a9d7-eeb447e40e52" alt="" width="300" />
            </td>
        </tr>
        <tr>
            <td style="padding:36px 30px 42px 30px;">
                <table role="presentation" style="width:100%;border-collapse:collapse;border:0;border-spacing:0;">
                    <tr>
                        <td style="width:260px;padding:0;vertical-align:top;color:#153643;">
                            <h1 style="font-size:28px;margin:0 0 20px 0;font-family:Arial,sans-serif;">Phiếu mời phụ huynh tham gia vào lớp</h1>
                        </td>
                    </tr>
                    <tr>
                        <td style="padding:0;">
                            <table role="presentation"
                                style="width:100%;border-collapse:collapse;border:0;border-spacing:0;">
                                <tr>
                                    <td style="width:260px;padding:0;vertical-align:top;color:#153643;">
                                        <p
                                            style="margin:0 0 25px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;">
                                            <img src="https://cdn-icons-png.flaticon.com/512/2784/2784403.png" alt=""
                                                width="200" style="height:auto;display:block;" />
                                        </p>
                                        <p
                                            style="margin:0 0 12px 0;font-size:20px;line-height:24px;font-family:Arial,sans-serif;">
                                        <div style="margin-left:30px">
                                            <h4>Giáo viên: $nameUser</h4>
                                            <h4>Lớp: $className</h4>
                                            <h4>Trường: $schoolName</h4>
                                        </div>

                                        </p>
                                    </td>
                                    <td style="width:20px;padding:0;font-size:0;line-height:0;">&nbsp;</td>
                                    <td style="width:260px;padding:0;vertical-align:top;color:#153643;">
                                        <p
                                            style="margin:0 0 25px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;">
                                            <img src="https://cdn-icons-png.flaticon.com/512/707/707659.png" alt=""
                                                width="200" style="height:auto;display:block;" />
                                        </p>
                                        <p
                                            style="margin:0 0 12px 0;font-size:16px;line-height:24px;font-family:Arial,sans-serif;">
                                        <div style="margin-left:20px">
                                            <h4>Học sinh: $nameStudent</h4>
                                            <h4>Mã tham gia lớp: $classId</h4>
                                         
                                        </div>

                                        </p>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td style=" padding:30px;background:#ee4c50;">
                <table role="presentation"
                    style="width:100%;border-collapse:collapse;border:0;border-spacing:0;font-size:9px;font-family:Arial,sans-serif;">
                    <tr>
                        <td style="padding:0;width:50%;" align="right">
                            <table role="presentation" style="border-collapse:collapse;border:0;border-spacing:0;">
                                <tr>
                                    <td style="padding:0 0 0 10px;width:38px;">
                                        <a href="http://www.twitter.com/" style="color:#ffffff;"><img
                                                src="https://assets.codepen.io/210284/tw_1.png" alt="Twitter" width="38"
                                                style="height:auto;display:block;border:0;" /></a>
                                    </td>
                                    <td style="padding:0 0 0 10px;width:38px;">
                                        <a href="http://www.facebook.com/" style="color:#ffffff;"><img
                                                src="https://assets.codepen.io/210284/fb_1.png" alt="Facebook"
                                                width="38" style="height:auto;display:block;border:0;" /></a>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <div style="line-height:10px;height:10px;mso-line-height-rule:exactly;">&nbsp;</div>
</body>

</html>''';

      message.html = yourHtmlTemplate.replaceAll('{{NAME}}', nameFromSomeInput);

      try {
        final sendReport = await send(message, smtpServer);
        print('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        print(e);
        for (var p in e.problems) {
          print('Problem: ${p.code}: ${p.msg}');
        }
      }
      setState(() {
        hasSentMail = !hasSentMail;
      });
    }
    else
    {

    }
  }
  bool get isPopulated =>
      emailController.text.isNotEmpty;
  bool isButtonEnabled()
  {
    return  isPopulated;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc()..add(LoadStudentNoParent()),
      child: BlocBuilder<StudentBloc,StudentState>(
        builder: (context, state) {
          if(state is LoadingStudent)
            {
              return Center(child: CircularProgressIndicator());
            }
          if(state is LoadedStudentNoParent)
            {
              var studentModel = state.studentModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text("Chưa kết nối ("+studentModel.length.toString()+")",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),),
                  ),
                  studentModel.length>0 ? ListView.builder(
                        key: UniqueKey(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: studentModel.length ,
                        itemBuilder: (context, index) {
                          return Container(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextButton(
                                    onPressed: (){
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return     Dialog(
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(15.sp),
                                              ),
                                              elevation: 0,
                                              backgroundColor: Colors.transparent,
                                              child: Stack(
                                                children: <Widget>[
                                                  Container(
                                                    padding: EdgeInsets.only(left: 20.sp,top: 45.sp
                                                        + 20.sp, right: 20.sp,bottom: 20.sp
                                                    ),
                                                    margin: EdgeInsets.only(top: 45.sp),
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.rectangle,
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(20.sp),
                                                        boxShadow: [
                                                          BoxShadow(color: Colors.black,offset: Offset(0,10),
                                                              blurRadius: 10
                                                          ),
                                                        ]
                                                    ),
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: <Widget>[
                                                        TextFormField(
                                                          controller: emailController,
                                                          validator: (val) {

                                                            val!.isEmpty || val == null || val!.contains( RegExp(
                                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                                                            ));

                                                          },
                                                          autovalidateMode: AutovalidateMode.always,
                                                          keyboardType: TextInputType.emailAddress,
                                                          decoration: InputDecoration(
                                                            labelText: "Email",
                                                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                                            enabledBorder: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.grey.shade400)
                                                            ),
                                                            border: OutlineInputBorder(
                                                                borderSide: BorderSide(color: Colors.teal)
                                                            ),

                                                          ),
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                          children: [
                                                            Align(
                                                              alignment: Alignment.bottomLeft,
                                                              child: TextButton(
                                                                  onPressed: (){
                                                                    Navigator.of(context).pop();
                                                                  },
                                                                  child: Text("Quay lại",style: TextStyle(fontSize: 18.sp,color: Colors.red),)),
                                                            ),
                                                            Align(
                                                              alignment: Alignment.bottomRight,
                                                              child: TextButton(
                                                                  onPressed: () async {
                                                                    Navigator.of(context).pop();
                                                                    Mailer(widget.classModel.className,
                                                                        widget.classModel.schoolName,
                                                                        widget.classModel.id+studentModel[index].id,
                                                                        nameUser, studentModel[index].name
                                                                    );
                                                                    MySnackBar.error(message:'Đã gửi lời mời tới phụ huynh học sinh', color: Colors.cyan, context: context);

                                                                  },
                                                                  child: Text("Mời",style: TextStyle(fontSize: 18.sp,color: Colors.blue),)),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Positioned(
                                                    left: 20.sp,
                                                    right: 20.sp,
                                                    child: CircleAvatar(
                                                      backgroundColor: Colors.transparent,
                                                      radius: 45.sp,
                                                      child: ClipRRect(
                                                          borderRadius: BorderRadius.all(Radius.circular(45.sp,)),
                                                          child: Image.asset("assets/target-audience.png")
                                                      )
                                                    ),
                                                  ),
                                                ],
                                              )
                                          );
                                        },);
                                    },
                                    child:  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: Row(
                                            children: [
                                              Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.grey,
                                                      radius: 23.4.sp,
                                                      child:
                                                      CircleAvatar(radius: 23.sp,
                                                        backgroundColor: Colors.white,
                                                        child:  Center(child: Icon(Icons.add,size: 30.sp,color: Colors.cyan,),),
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                              SizedBox(width: 10,),
                                        SizedBox(
                                        width: 60.w,
                                        child: ConstrainedBox(
                                            constraints: BoxConstraints(maxWidth: 400),
                                            child: Text("P/h em: " + studentModel[index].name,  maxLines: 2,
                                              style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.w700),)
                                        ),
                                      ),
                                              // StreamBuilder(
                                              //   stream:  FirebaseFirestore.instance.collection("users").doc(studentModel[index].idParent).snapshots(),
                                              //   builder: (context,  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                              //     var snap = snapshot.data ;
                                              //     if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                                              //   return   Column(
                                              //     children: [
                                              //       SizedBox(
                                              //         width: 60.w,
                                              //         child: ConstrainedBox(
                                              //             constraints: BoxConstraints(maxWidth: 400),
                                              //             child: Text("P/h em: " + studentModel[index].name,  maxLines: 2,
                                              //               style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.w700),)
                                              //         ),
                                              //       ),
                                              //       SizedBox(
                                              //         width: 60.w,
                                              //         child: ConstrainedBox(
                                              //             constraints: BoxConstraints(maxWidth: 400),
                                              //             child: Text(snap!.docs["fristName"],  maxLines: 2,
                                              //               style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.w700),)
                                              //         ),
                                              //       ),
                                              //     ],
                                              //   );
                                              // },
                                              // )

                                            ],
                                          ),
                                        ),

                                         Padding(
                                           padding: const EdgeInsets.only(right: 12.0),
                                           child: Text("Mời",style: TextStyle(fontSize: 15.sp,color: Colors.cyan),),
                                         ),

                                      ],
                                    )
                                )
                            ),
                          );
                        },
                      ):Center()


                ],
              );
            }
          return Center();
        },
      ),
    );
  }
}
