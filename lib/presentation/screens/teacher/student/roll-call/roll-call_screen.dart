import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../data/repository/chat_repository/firebase_chat_repo.dart';
import '../../../../../data/repository/notification_repository/firebase_notifi_repo.dart';
import '../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../utils/pushnotifications.dart';
import '../../../../../utils/snackbar.dart';
import '../../../../common_blocs/student/bloc.dart';

class RollCallScreen extends StatefulWidget {
  const RollCallScreen({Key? key}) : super(key: key);

  @override
  State<RollCallScreen> createState() => _RollCallScreenState();
}

class _RollCallScreenState extends State<RollCallScreen> {
  var currentdate = DateTime.now();
  FirebaseNotificationRepository firebaseNotificationRepository = new FirebaseNotificationRepository();
  String nameClass ='';
  String avatar ='';
  FirebaseChatRepository firebaseChatRepository = new FirebaseChatRepository();
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  String pushToken ="";
  // List<Icon> icon = [Icon(Icons.add), Icon(Icons.access_alarm), Icon(Icons.accessibility),Icon(Icons.add_chart_rounded)];
  List img =
  [
    'assets/icons8-teaching-48.png',
    'assets/icons8-teaching-481.png',
    'assets/icons8-teaching-482.png',
    'assets/icons8-teaching-483.png',
  ];
  List<Text> text = [
    Text("Đi học",style: TextStyle(fontSize: 15.sp,color: Colors.blue),),
    Text("Đi muộn",style: TextStyle(fontSize: 15.sp,color: Colors.yellow.shade700),),
    Text("Nghỉ không phép",style: TextStyle(fontSize: 15.sp,color: Colors.red),),
    Text("Nghỉ có phép",style: TextStyle(fontSize: 15.sp,color: Colors.grey),)
  ];

  Future getclassId()
  async {
    final prefs =  await SharedPreferences.getInstance();
    String? classId = prefs.getString('classId');
    return classId;
  }

  Future<void> onPress(bool isConnect,int rollCall, userId,String classId, String name)
  async {
    await firebaseChatRepository.loadNameClass(classId!).then((value) {
      nameClass = value;
    });
    await firebaseChatRepository.loadAvatarClass(classId!).then((value) {
      avatar = value;
    });
    if(pushToken!= "" && rollCall ==0)
    {
      PushNotifications.callOnFcmApiSendPushNotifications(
          body:  name + " đã có mặt tại lớp",
          To: pushToken!);

      if(userId != null)
      {
        await firebaseNotificationRepository.AddNotifiCation(
          userId,
          name + " đã có mặt tại lớp",
          avatar,
          nameClass,
          false,
        );
      }
    }
    else if(pushToken!= "" && rollCall ==1)
    {
      PushNotifications.callOnFcmApiSendPushNotifications(
          body:  name + " đi học trễ",
          To: pushToken!);
      if(userId != null)
      {
        await firebaseNotificationRepository.AddNotifiCation(
          userId,
          name + " đi học trễ",
          avatar,
          nameClass,
          false,
        );
      }
    }
    else if(pushToken!= "" && rollCall ==2)
    {
      PushNotifications.callOnFcmApiSendPushNotifications(
          body:  name + " nghỉ học không phép",
          To: pushToken!);
      if(userId != null)
      {
        await firebaseNotificationRepository.AddNotifiCation(
          userId,
          name + " nghỉ học không phép",
          avatar,
          nameClass,
          false,
        );
      }
    }
    else if(pushToken!= "" && rollCall ==3)
    {
      PushNotifications.callOnFcmApiSendPushNotifications(
          body:  name + " nghỉ học có phép",
          To: pushToken!);

      if(userId != null)
      {
        await firebaseNotificationRepository.AddNotifiCation(
          userId,
          name + " nghỉ học có phép",
          avatar,
          nameClass,
          false,
        );
      }
    }
  StudentBloc()..add(AddRollCall(name, DateFormat('yyyy-MM-dd').format(currentdate), rollCall));
  }
  @override
  void initState()  {
    initializeDateFormatting('vi');
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   BlocBuilder<StudentBloc,StudentState>(
      bloc: StudentBloc()..add(LoadStudent()),
      buildWhen: (previous, current) => current is LoadedStudent,
      builder: (context, state) {
        if (state is LoadingStudent)
        {
          return Center(child: CircularProgressIndicator());
        }
        if(state is LoadedStudent)
        {
          var studentModel = state.studentModel;
          return FutureBuilder(
            future: getclassId(),
            builder: (context, snapshot) =>  Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(color: Colors.black),
                title:  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Text('Điểm danh',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
                ),
                centerTitle: true,
                leading: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: MaterialButton(
                    onPressed: () async {
                      Navigator.of(context).pop();
                      final prefs = await SharedPreferences.getInstance();
                      final String? classId = prefs.getString('classId');
                      var _studentCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("student").where('rollCall');
                      var querySnapshots = await _studentCollection.get();
                      for (var doc in querySnapshots.docs) {
                        await doc.reference.update({
                          'rollCall' : 0
                        });
                      }
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
                actions: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(AppRouter.ROLLCALLLISTEXPORT,arguments: snapshot.data.toString());
                      },
                      icon: Icon(Icons.print,size: 22.sp,color: Colors.grey,)),
                  IconButton(
                      onPressed: ()  {
                        studentModel.forEach((element) async {
                          if(element.isConnect)
                          {
                           await userAuthRepository.getUserByID(element.idParent).then((value)
                            {
                                pushToken = value.pushToken;
                            });
                           onPress(element.isConnect,element.rollCall!,element.idParent,snapshot.data.toString(), element.name);
                          }
                          else
                            {
                                pushToken = '';
                            }
                        });
                        MySnackBar.error(message: "Đã thông báo tới các phụ huynh trong lớp", color: Colors.cyan, context: context);

                      },
                      icon: Icon(Icons.check,size: 22.sp,color: Colors.grey,)),
                ],
              ),
              resizeToAvoidBottomInset: false,
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Text(
                        DateFormat.MMMEd('vi').format(currentdate),
                        style: Theme.of(context)
                            .textTheme
                            .headline1!
                            .copyWith(fontSize: 25.sp),
                      ),
                    ),

                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 10.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.sp),
                                boxShadow:
                                [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),

                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 2.h,),
                                  Text("Đi học",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                  SizedBox(height: 0.5.h,),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("class").doc(snapshot.data.toString()).collection("student").where('rollCall' ,isEqualTo: 0).snapshots(),
                                      builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot)
                                      {
                                        if (snapshot.hasData || snapshot.data != null)
                                        {
                                          return  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width:20.w,
                                                  child: Center(child:
                                                  Text(snapshot.data!.docs.length.toString(),
                                                    maxLines:2,
                                                    style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w900,color: Colors.blue),))
                                              )
                                            ],
                                          );
                                        }
                                        return Center();
                                      }
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Container(
                              height: 10.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.sp),
                                boxShadow:
                                [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),

                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 2.h,),
                                  Text("Xin nghỉ",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                  SizedBox(height: 0.5.h,),
                                  StreamBuilder(
                                      stream: FirebaseFirestore
                                          .instance
                                          .collection("class").doc(
                                          snapshot.data.toString())
                                          .collection("student")
                                          .where(
                                          'rollCall', isEqualTo: 2)
                                          .snapshots(),
                                      builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot1) {

                                        if (snapshot1.hasData || snapshot1.data != null)
                                        {
                                          return StreamBuilder(
                                              stream: FirebaseFirestore
                                                  .instance
                                                  .collection("class").doc(
                                                  snapshot.data.toString())
                                                  .collection("student")
                                                  .where(
                                                  'rollCall', isEqualTo: 3)
                                                  .snapshots(),
                                              builder: (context,
                                                  AsyncSnapshot<
                                                      QuerySnapshot> snapshot2) {
                                                int length1 = snapshot1.data?.docs.length ?? 0;
                                                int length2= snapshot2.data?.docs.length ?? 0;
                                                int length = length1 + length2;
                                                if (snapshot1.hasData || snapshot1.data != null)
                                                {
                                                  return Row(
                                                    mainAxisAlignment: MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      SizedBox(
                                                          width: 20.w,
                                                          child: Center(
                                                              child:
                                                              Text(
                                                                length
                                                                    .toString(),
                                                                maxLines: 2,
                                                                style: TextStyle(
                                                                    fontSize: 20
                                                                        .sp,
                                                                    fontWeight: FontWeight
                                                                        .w900,
                                                                    color: Colors
                                                                        .red),))
                                                      )
                                                    ],
                                                  );
                                                }
                                                return Center();
                                              }
                                          );
                                        }
                                        return Center();

                                      }
                                  )

                                ],
                              ),
                            ),
                            SizedBox(width: 5.w,),
                            Container(
                              height: 10.h,
                              width: 25.w,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.sp),
                                boxShadow:
                                [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),

                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 2.h,),
                                  Text("Đi muộn",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                                  SizedBox(height: 0.5.h,),
                                  StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("class").doc(snapshot.data.toString()).collection("student").where('rollCall' ,isEqualTo: 1).snapshots(),
                                      builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot)
                                      {
                                        if (snapshot.hasData || snapshot.data != null)
                                        {
                                          return  Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                  width:20.w,
                                                  child: Center(child:
                                                  Text(snapshot.data!.docs.length.toString(),
                                                    maxLines:2,
                                                    style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w900,color: Colors.yellow.shade700),))
                                              )
                                            ],
                                          );
                                        }
                                        return Center();
                                      }
                                  ),
                                ],
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 3.h,),
                        Stack(
                          children: [
                            studentModel.length>0 ? ListView.builder(
                              key: UniqueKey(),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: studentModel.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  child: Padding(
                                      padding: const EdgeInsets.only(left: 5,top: 5),
                                      child: TextButton(
                                          onPressed: ()async{
                                            if(studentModel[index].rollCall! < 3)
                                            {
                                              final prefs = await SharedPreferences.getInstance();
                                              final String? classId = prefs.getString('classId');
                                              var _studentCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("student");

                                              await _studentCollection.doc(studentModel[index].id).update({
                                                'rollCall' : studentModel[index].rollCall! +1
                                              });

                                            }
                                            else if (studentModel[index].rollCall! >=3)
                                            {
                                              final prefs = await SharedPreferences.getInstance();
                                              final String? classId = prefs.getString('classId');
                                              var _studentCollection = FirebaseFirestore.instance.collection("class").doc(classId).collection("student");

                                              await _studentCollection.doc(studentModel[index].id).update({
                                                'rollCall' : 0
                                              });
                                            }
                                          },
                                          child:  Container(
                                            child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                  Stack(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundColor: Color(0xff00A3FF),
                                                          backgroundImage: NetworkImage(studentModel[index].avatar),
                                                          radius: 22.sp,
                                                        ),
                                                      ]
                                                  ),
                                                  SizedBox(width: 5.w,),
                                                  Expanded(
                                                    child: SizedBox(
                                                      width: 35.w,
                                                      child: ConstrainedBox(
                                                          constraints: BoxConstraints(maxWidth: 400),
                                                          child: Text(studentModel[index].name,  maxLines: 2,
                                                            style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),)
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(width: 2.w,),
                                                  text[studentModel[index].rollCall!],
                                                  SizedBox(width: 2.w,),
                                                  Image(image: AssetImage(img[studentModel[index].rollCall!]))
                                                ]
                                            ),
                                          )
                                      )
                                  ),
                                );
                              },
                            ) :Center()

                          ],
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          );


        }
        if(state is LoadFailStudent) { }
        return Center();
      }

    );
  }
}
