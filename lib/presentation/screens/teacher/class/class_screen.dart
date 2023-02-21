import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/repository/class_repository/firebase_class_repo.dart';
import 'package:luan_an/presentation/screens/login/login_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:to_csv/to_csv.dart' as exportCSV;
import '../../../../utils/snackbar.dart';
import '../../signup/helper/FadeAnimation.dart';
import '../student/student_screen.dart';

class ClassScreen extends StatefulWidget {
  final ClassModel classModel;
  const ClassScreen({Key? key,required this.classModel}) : super(key: key);

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen>{
  FirebaseClassRepository firebaseClassRepository = new FirebaseClassRepository();

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,

        home:  Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
              title:  ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text(widget.classModel.className,  maxLines: 4,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
              actions: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("class").doc(widget.classModel.id).collection("notification").where("isSeen",isEqualTo: false).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return IconButton(
                        onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.CLASSNOTIFICATION),
                        icon: Stack(
                          children: [
                            Icon(Icons.notifications_none_outlined,size: 22.sp,color: Colors.grey,),
                            if (snapshot.hasData)
                              ...[
                                snapshot.data!.docs.length>0?
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.white
                                        ),
                                        borderRadius: BorderRadius.circular(100.0),
                                        color: Colors.red,
                                      ),
                                      child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                                    )
                                ):   Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.white
                                        ),
                                        borderRadius: BorderRadius.circular(100.0),
                                        color: Colors.red,
                                      ),)
                                ),
                              ]


                          ],
                        )
                    );
                  },

                ),
                IconButton(onPressed: (){
                  Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.ROLLCALL);
                }, icon: Icon(Icons.people,color: Colors.grey,)),
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
                                  Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.ADDSCREEN,arguments: widget.classModel);
                                }, child: Row(
                                  children: [
                                    Icon(Icons.contact_phone_rounded,size: 25.sp,color: Colors.grey,),
                                    Text(" Kết nối với lớp",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                                  ],
                                )),
                                TextButton(onPressed: (){
                                  Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.EXPORTCSV);
                                }, child: Row(
                                  children: [
                                    Icon(Icons.print,size: 25.sp,color: Colors.grey,),
                                    Text(" Xuất dữ liệu",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                                  ],
                                )),
                                if(widget.classModel.leader == FirebaseAuth.instance.currentUser!.uid)
                                  ...[
                                    TextButton(onPressed: (){
                                      Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.EDITCLASS,arguments: widget.classModel);

                                    }, child: Row(
                                      children: [
                                        Icon(Icons.edit,size: 25.sp,color: Colors.grey,),
                                        Text(" Sửa thông tin lớp",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                                      ],
                                    )),
                                  ],

                                if(widget.classModel.leader == FirebaseAuth.instance.currentUser!.uid)
                                 ... [
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
                                                       Text("Bạn có chắc chắn muốn xóa lớp học!",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700),),
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
                                                                   try{
                                                                     firebaseClassRepository.deleteClass(widget.classModel.id);
                                                                     MySnackBar.error(message: "Xóa lớp thành công",color: Colors.cyan, context: context);

                                                                   }catch(e)
                                                                   {
                                                                     MySnackBar.error(message: "Xóa lớp không thành công",color: Colors.red, context: context);

                                                                   }
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
                                       Text(" Xóa lớp",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
                                     ],
                                   )),
                                  ]
                                else if(widget.classModel.leader != FirebaseAuth.instance.currentUser!.uid)
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
                                                        Text("Bạn có chắc chắn muốn rời khỏi lớp",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700),),
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
                                                                    try{
                                                                      firebaseClassRepository.getOutClass(widget.classModel.id);
                                                                      MySnackBar.error(message: "Đã rời khỏi lớp",color: Colors.cyan, context: context);

                                                                    }catch(e)
                                                                    {
                                                                      MySnackBar.error(message: "Có lỗi xảy ra",color: Colors.red, context: context);

                                                                    }
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
                                        Icon(Icons.outbound_rounded,size: 25.sp,color: Colors.grey,),
                                        Text(" Rời khỏi lớp",style: TextStyle(fontSize: 17.sp,color: Colors.black87),)
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
            body: StudentScreen(classModel:widget.classModel),
          )


    );
  }
}
