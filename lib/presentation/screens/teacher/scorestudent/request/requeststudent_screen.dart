import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../../../../../data/repository/notification_repository/firebase_notifi_repo.dart';
import '../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../utils/pushnotifications.dart';
class RequestStudentScreen extends StatefulWidget {
  final StudentModel studentModel;
  const RequestStudentScreen({Key? key, required this.studentModel}) : super(key: key);

  @override
  State<RequestStudentScreen> createState() => _RequestStudentScreenState();
}

class _RequestStudentScreenState extends State<RequestStudentScreen> with AutomaticKeepAliveClientMixin<RequestStudentScreen>{
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  FirebaseNotificationRepository firebaseNotificationRepository = new FirebaseNotificationRepository();
  String pushToken ="";
  late String nameUser;
  @override

  @override
  void initState() {
    userAuthRepository.getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
      nameUser = value.sex +" "+ value.firstName + " " + value.lastName;
    });
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
    if(widget.studentModel.isConnect == true)
    {
      return SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder(
              bloc: StudentBloc()..add(LoadClassRequest(
                  widget.studentModel.id!)),
              builder: (context, state) {
                if(state is LoadedRequest)
                {
                  var requestModel = state.requestModel;
                  return  ListView.builder(
                      key: UniqueKey(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: requestModel.length,
                      itemBuilder: (context, index) {
                        return  Container(
                                child: Padding(
                                    padding: const EdgeInsets.only(left: 10,top: 10,right: 10,bottom: 10),
                                    child: InkWell(
                                        onTap: (){
                                          showDialog(
                                            context: context,
                                            builder: (context) {
                                              if(requestModel[index].appcept == true)
                                              {
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
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                width: 70.w,
                                                                child: ConstrainedBox(
                                                                    constraints: BoxConstraints(maxWidth: 400),
                                                                    child: Text(requestModel[index].content,  maxLines: 2,
                                                                      style: TextStyle(fontSize: 18.sp),)
                                                                ),
                                                              ),
                                                              ConstrainedBox(
                                                                  constraints: BoxConstraints(maxWidth: 400),
                                                                  child: Text(
                                                                    DateFormat.yMd().add_jm().format(requestModel[index].timeCreate.toDate()),
                                                                    maxLines: 2,
                                                                    style: TextStyle(fontSize: 15.sp,color: Colors.blue),)
                                                              ),

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
                                                                borderRadius: BorderRadius.all(Radius.circular(35.sp,)),
                                                                child: Image.asset(requestModel[index].img)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                );
                                              }
                                              else if(requestModel[index].appcept == false)
                                              {
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
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              SizedBox(
                                                                width: 70.w,
                                                                child: ConstrainedBox(
                                                                    constraints: BoxConstraints(maxWidth: 400),
                                                                    child: Text(requestModel[index].content,  maxLines: 2,
                                                                      style: TextStyle(fontSize: 18.sp),)
                                                                ),
                                                              ),
                                                              ConstrainedBox(
                                                                  constraints: BoxConstraints(maxWidth: 400),
                                                                  child: Text(
                                                                    DateFormat.yMd().add_jm().format(requestModel[index].timeCreate.toDate()),
                                                                    maxLines: 2,
                                                                    style: TextStyle(fontSize: 15.sp,color: Colors.blue),)
                                                              ),
                                                              SizedBox(height: 1.h,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    width:60.w,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.blue,
                                                                      border: Border.all(
                                                                          width: 8,
                                                                          color: Colors.blue
                                                                      ),
                                                                      borderRadius: BorderRadius.circular(12),
                                                                    ),
                                                                    child: Align(
                                                                      alignment: Alignment.center,
                                                                      child: TextButton(
                                                                          onPressed: () async {
                                                                            StudentBloc()..add(UpdateModelRequest(requestModel[index].id,widget.studentModel.idParent,nameUser));
                                                                            Navigator.of(context).pop();
                                                                            if(pushToken!= "")
                                                                            {
                                                                              PushNotifications.callOnFcmApiSendPushNotifications(
                                                                                  body: nameUser+ ' đã xác nhận yêu cầu của bạn',
                                                                                  To: pushToken!);
                                                                            }


                                                                          },
                                                                          child: Text("Xác nhận",style: TextStyle(fontSize: 18.sp,color: Colors.white),)),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),

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
                                                                borderRadius: BorderRadius.all(Radius.circular(35.sp,)),
                                                                child: Image.asset(requestModel[index].img)
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                );
                                              }
                                              return Center();
                                            },);
                                        },
                                        child:  Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(width: 1,color: Colors.grey),
                                            borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                                          ),
                                          child: Row(
                                            children: [
                                              Stack(
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundColor: Colors.transparent,
                                                      backgroundImage: AssetImage(requestModel[index].img),
                                                      radius: 25.sp,
                                                    ),
                                                  ]
                                              ),
                                              SizedBox(width: 10,),
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(
                                                    width: 63.w,
                                                    child: ConstrainedBox(
                                                        constraints: BoxConstraints(maxWidth: 400),
                                                        child: Text(requestModel[index].title,  maxLines: 2,
                                                          style: TextStyle(fontSize: 18.sp),)
                                                    ),
                                                  ),
                                                  ConstrainedBox(
                                                      constraints: BoxConstraints(maxWidth: 400),
                                                      child: Text(
                                                        DateFormat.yMd().add_jm().format(requestModel[index].timeCreate.toDate()),
                                                        maxLines: 2,
                                                        style: TextStyle(fontSize: 15.sp,color: Colors.blue),)
                                                  ),
                                                ],
                                              ),
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: requestModel[index].appcept? Icon(Icons.check_circle,color: Colors.blue,) :Icon(Icons.check_circle_outline_sharp,color: Colors.blue),

                                              )
                                            ],
                                          ),
                                        )
                                    )
                                ),

                        );
                      },
                  );
                }
                return Text('');
              },
            ),
          ],

        ),
      );
    }
    return Center();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
