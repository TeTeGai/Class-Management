import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/request/requeststudent_screen.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/score/score_screen.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../configs/router.dart';
import '../../../../data/model/class_model.dart';
import '../../../../utils/snackbar.dart';
import '../../signup/helper/FadeAnimation.dart';
import 'gpa/gpa_screen.dart';


class ScoreStudentScreen extends StatefulWidget {
  final StudentModel studentModel;
  final ClassModel classModel;
  const ScoreStudentScreen({Key? key, required this.studentModel, required this.classModel}) : super(key: key);

  @override
  State<ScoreStudentScreen> createState() => _ScoreStudentScreenState();
}

class _ScoreStudentScreenState extends State<ScoreStudentScreen> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
              title:  ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text(widget.studentModel.name,  maxLines: 4,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
              bottom: TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text("Rèn luyện",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),
                    ),
                    Tab(
                      child: Text("Điểm số",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),
                    ),

                    Tab(
                      // child: Text("Yêu cầu",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),
                      child:   StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("class").doc(widget.classModel.id).collection("request").where("idStudent",isEqualTo: widget.studentModel.id).where('appcept',isEqualTo: false).snapshots(),
                        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(snapshot.hasData)
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              if (snapshot.data!.docs.length>0)
                                ...[
                                  Container(
                                    height: 1.5.h,
                                    width: 3.w,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.white
                                      ),
                                      borderRadius: BorderRadius.circular(100.0),
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              Text("Yêu cầu",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),),
                            ],

                          );
                          return  Text("Yêu cầu",style:TextStyle(fontSize: 17.sp,fontWeight: FontWeight.w400),);
                        },

                      ),
                    ),
                  ]),
              actions: [
                CustomPopupMenu(
                  pressType: PressType.singleClick,
                  arrowColor: Colors.black45,
                  menuBuilder: () => ClipRect(
                      clipBehavior: Clip.hardEdge,
                      child:
                      FadeAnimation(0.0,
                        Container(
                          width: 30.h ,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                15.sp),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [

                              TextButton(onPressed: (){

                                Navigator.of(context).pushNamed(AppRouter.STATISTIC,arguments: widget.studentModel,);
                              }, child: Row(
                                children: [
                                  Icon(Icons.pie_chart,size: 25.sp,color: Colors.grey,),
                                  Text(" Thống kê",style: TextStyle(fontSize: 17.sp,color: Colors.black87),),
                                ],
                              )),
                              TextButton(onPressed: (){
                                Navigator.of(context).pushNamed(AppRouter.HOMESTATISTIC,arguments: widget.studentModel,);
                              }, child: Row(
                                children: [
                                  Icon(Icons.star_border,size: 25.sp,color: Colors.grey,),
                                  Text(" Xem điểm ở nhà",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                                ],
                              )),
                              if(widget.classModel.leader == FirebaseAuth.instance.currentUser!.uid)
                                ...[
                                  TextButton(onPressed: (){
                                    Navigator.of(context).pushNamed(AppRouter.EDITSTUDENT,arguments: [widget.studentModel,"Student"],);
                                  }, child: Row(
                                    children: [
                                      Icon(Icons.edit,size: 25.sp,color: Colors.grey,),
                                      Text(" Chỉnh sửa thông tin",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                                    ],
                                  )),
                                ],
                              if(widget.classModel.leader == FirebaseAuth.instance.currentUser!.uid)
                                ...[
                                  TextButton(onPressed: (){
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
                                                      Text("Bạn có chắc chắn muốn xóa học sinh!",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700),),
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
                                                                  Navigator.of(context).pop();
                                                                  StudentBloc().add(RemoveStudent(widget.studentModel.id));
                                                                  MySnackBar.error(message: "Xóa thông tin thành công", color: Colors.cyan, context: context,);


                                                                },
                                                                child: Text("Xác nhận",style: TextStyle(fontSize: 18.sp,color: Colors.red),)),
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
                                                          child: Image.asset("assets/stop.png")
                                                      )
                                                  ),
                                                ),
                                              ],
                                            )
                                        );
                                      },);
                                  }, child: Row(
                                    children: [
                                      Icon(Icons.delete,size: 25.sp,color: Colors.grey,),
                                      Text(" Xóa học sinh",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                                    ],
                                  )),
                                ]



                            ],
                          ),
                        ),
                      )

                  ),
                  child:    Icon(Icons.more_vert,size: 24,color: Colors.grey,),
                )


              ],
            ),
            resizeToAvoidBottomInset: false,
            body: TabBarView(
              children: [
                GpaScreen(studentModel: widget.studentModel),
                ScoreScreen(studentModel: widget.studentModel),
                RequestStudentScreen(studentModel: widget.studentModel)
              ],
            ),
          )),
      debugShowCheckedModeBanner: false,
    );
  }
}
