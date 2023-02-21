import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/soninfor/widget/gpabadson_form.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/soninfor/widget/gpagoodson_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../utils/snackbar.dart';
import '../../../../../common_blocs/student/bloc.dart';
import '../../../../signup/helper/FadeAnimation.dart';

class SonInformation extends StatefulWidget {
  final StudentModel studentModel;

  const SonInformation({Key? key, required this.studentModel,}) : super(key: key);

  @override
  State<SonInformation> createState() => _SonInformationState();
}



class _SonInformationState extends State<SonInformation> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            title:  ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Text(widget.studentModel.name,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
            actions: [
              IconButton(onPressed: (){
                widget.studentModel.isConnect ?
                Navigator.of(context).pushNamed(AppRouter.SONCALENDAR,arguments: widget.studentModel.classId):
                MySnackBar.error(message: "Vui lòng kết nối tới lớp học", color: Colors.red, context: context);
              }, icon: Icon(Icons.calendar_month)),
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
                              widget.studentModel.isConnect ?
                              Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.REQUESTTOCLASS,arguments: widget.studentModel):
                              MySnackBar.error(message: "Vui lòng kết nối tới lớp học", color: Colors.red, context: context);


                            }, child: Row(
                              children: [
                                Icon(Icons.contact_phone_rounded,size: 25.sp,color: Colors.grey,),
                                Text(" Yêu cầu tới giáo viên",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                              ],
                            )),

                            TextButton(onPressed: (){
                              Navigator.of(context).pushNamed(AppRouter.CONNECTSON,arguments: widget.studentModel);
                            }, child: Row(
                              children: [
                                Icon(Icons.person_add_alt_1,size: 25.sp,color: Colors.grey,),
                                Text(" Kết nối lớp mới",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                              ],
                            )),

                            TextButton(onPressed: (){
                              Navigator.of(context).pushNamed(AppRouter.EDITSTUDENT,arguments: [widget.studentModel,"Son"] );
                            }, child: Row(
                              children: [
                                Icon(Icons.edit,size: 25.sp,color: Colors.grey,),
                                Text(" Chỉnh sửa thông tin",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                              ],
                            )),

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
                                                Text("Bạn có chắc chắn muốn thông tin của con!",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700),),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Align(
                                                      alignment: Alignment.bottomLeft,
                                                      child: TextButton(
                                                          onPressed: (){
                                                            Navigator.of(context).pop();
                                                          },
                                                          child: Text("Quay lại",style: TextStyle(fontSize: 18,color: Colors.red),)),
                                                    ),
                                                    Align(
                                                      alignment: Alignment.bottomRight,
                                                      child: TextButton(
                                                          onPressed: () async {
                                                            Navigator.of(context).pop();
                                                            Navigator.of(context).pop();
                                                            StudentBloc().add(RemoveSon(widget.studentModel.id));
                                                            MySnackBar.error(message: "Xóa thông tin thành công", color: Colors.cyan, context: context,);
                                                          },
                                                          child: Text("Xác nhận",style: TextStyle(fontSize: 18,color: Colors.red),)),
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
                                Text(" Xóa thông tin con",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                              ],
                            )),
                          ],
                        ),
                      ),
                    )
                ),
                child:    Icon(Icons.more_vert,size: 24,color: Colors.grey,),
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                SizedBox(height: 2.h,),
                Center(
                  child: CircleAvatar(
                    radius: 24.sp,
                    backgroundImage: NetworkImage(widget.studentModel.avatar),
                  ),
                ),
                SizedBox(height: 2.h,),
                Center(child: Text("Thống kê rèn luyện của "+ widget.studentModel.name,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w400),)),
                SizedBox(height: 1.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: (){
                        widget.studentModel.isConnect?
                        Navigator.of(context).pushNamed(AppRouter.GPASONSTATISTIC,arguments: widget.studentModel):
                        MySnackBar.error(message: "Vui lòng kết nối tới lớp học", color: Colors.red, context: context,);

                      },
                      child: Container(
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
                            Text("Lớp",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                            SizedBox(height: 1.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.studentModel.isConnect?
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("class").doc(widget.studentModel.classId).collection("gpaList").where('idStudent' ,isEqualTo: widget.studentModel.idStudent).where('category',isEqualTo: "GoodGPA").snapshots(),
                                    builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot)
                                    {
                                      if (snapshot.hasData || snapshot.data != null)
                                      {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                                          child: SizedBox(
                                              width:11.w,
                                              child: Center(child: Text(snapshot.data!.docs.length.toString(),maxLines:2,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Colors.cyan),))
                                          ),
                                        );
                                      }
                                      return Center();
                                    }
                                ):Center(),
                                widget.studentModel.isConnect?
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("class").doc(widget.studentModel.classId).collection("gpaList").where('idStudent' ,isEqualTo: widget.studentModel.idStudent).where('category',isEqualTo: "BadGPA").snapshots(),
                                    builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot)
                                    {
                                      if (snapshot.hasData || snapshot.data != null)
                                      {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                                          child: SizedBox(
                                              width:11.w,
                                              child: Center(child: Text(snapshot.data!.docs.length.toString(),maxLines:2,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Colors.red),))
                                          ),
                                        );
                                      }
                                      return Center();
                                    }
                                ):Center(),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w,),
                    TextButton(
                      onPressed: (){
                        widget.studentModel.isConnect?
                        Navigator.of(context).pushNamed(AppRouter.GPASONSTATISTIC,arguments: widget.studentModel):
                        MySnackBar.error(message: "Vui lòng kết nối tới lớp học", color: Colors.red, context: context,);
                      },
                      child: Container(
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
                            Text("Ở nhà",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700),),
                            SizedBox(height: 1.h,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                widget.studentModel.isConnect?
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("class").doc(widget.studentModel.classId).collection("gpaHomeList").where('idStudent' ,isEqualTo: widget.studentModel.idStudent).where('category',isEqualTo: "GoodGPA").snapshots(),
                                    builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot)
                                    {
                                      if (snapshot.hasData || snapshot.data != null)
                                      {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                                          child: SizedBox(
                                              width:11.w,
                                              child: Center(child: Text(snapshot.data!.docs.length.toString(),maxLines:2,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Colors.cyan),))
                                          ),
                                        );
                                      }
                                      return Center();
                                    }
                                ):Center(),
                                widget.studentModel.isConnect?
                                StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection("class").doc(widget.studentModel.classId).collection("gpaHomeList").where('idStudent' ,isEqualTo: widget.studentModel.idStudent).where('category',isEqualTo: "BadGPA").snapshots(),
                                    builder: (context,  AsyncSnapshot<QuerySnapshot> snapshot)
                                    {
                                      if (snapshot.hasData || snapshot.data != null)
                                      {
                                        return Padding(
                                          padding: const EdgeInsets.only(left: 2.0,right: 2.0),
                                          child: SizedBox(
                                              width:11.w,
                                              child: Center(child: Text(snapshot.data!.docs.length.toString(),maxLines:2,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w700,color: Colors.red),))
                                          ),
                                        );
                                      }
                                      return Center();
                                    }
                                ):Center(),
                              ],
                            ),
                          ],
                        ),

                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 10),
                  child: Text("Tích cực",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                ),
                GpaGoodSonForm(studentModel: widget.studentModel),

                Padding(
                  padding: const EdgeInsets.only(left: 8.0,top: 10),
                  child: Text("Cần cải thiện",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),),
                ),
                GpaBadSonForm(studentModel: widget.studentModel),
              ],
            ),
          )

      ),
    );
  }
}
