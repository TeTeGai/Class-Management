import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/data/repository/student_repository/student_repo.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/repository/student_repository/firebase_student_repo.dart';
class RequestToClassScreen extends StatefulWidget {
  final StudentModel studentModel;
  const RequestToClassScreen({Key? key, required this.studentModel}) : super(key: key);

  @override
  State<RequestToClassScreen> createState() => _RequestToClassScreenState();
}

class _RequestToClassScreenState extends State<RequestToClassScreen> {
  FirebaseStudentRepository firebaseStudentRepository = new FirebaseStudentRepository();
  String name ="";
  @override
  void initState() {
    if(widget.studentModel.isConnect)
    {
      firebaseStudentRepository.getStudentByID(widget.studentModel.classId!,widget.studentModel.idStudent!).then((value)
      {
        setState(() {
          name = value.name;
        });
      });
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text("Yêu cầu",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
            Navigator.of(context).pushNamed(AppRouter.ADDREQUEST,arguments: [widget.studentModel,name]);
          }, icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocBuilder(
              bloc: StudentBloc()..add(LoadRequest(
                  widget.studentModel.classId!,
                  widget.studentModel.idStudent!)),
              builder: (context, state) {
                if(state is LoadedRequest)
                  {
                    var requestModel = state.requestModel;
                    return ListView.builder(
                      key: UniqueKey(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: requestModel.length,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                              padding: const EdgeInsets.all(10),
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
                                                                  style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
                                                            ),
                                                          ),
                                                          ConstrainedBox(
                                                              constraints: BoxConstraints(maxWidth: 400),
                                                              child: Text(
                                                                DateFormat.yMd().add_jm().format(requestModel[index].timeCreate.toDate()),
                                                                maxLines: 2,
                                                                style: TextStyle(fontSize: 15.sp,),)
                                                          ),

                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      left: 20.sp,
                                                      right: 20.sp,
                                                      child: CircleAvatar(
                                                        backgroundColor: Colors.white,
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
                                                                  style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
                                                                height: 7.h,
                                                                decoration: BoxDecoration(
                                                                  color: Colors.red,
                                                                  border: Border.all(
                                                                    width: 8,
                                                                    color: Colors.red
                                                                  ),
                                                                  borderRadius: BorderRadius.circular(12),
                                                                ),
                                                                child: Align(
                                                                  alignment: Alignment.center,
                                                                  child: InkWell(
                                                                      onTap: (){
                                                                        StudentBloc()..add(RemoveRequest(widget.studentModel.classId!, requestModel[index].id));
                                                                        Navigator.of(context).pop();

                                                                      },
                                                                      child: Text("Xóa",style: TextStyle(fontSize: 18.sp,color: Colors.white),)),
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
                                                backgroundImage: AssetImage(requestModel[index].img),
                                                backgroundColor: Colors.transparent,
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
                                                    style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
                                          child: requestModel[index].appcept? Icon(Icons.check_circle,color: Colors.blue) :Icon(Icons.check_circle_outline_sharp,color: Colors.blue),

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
      ),
    );
  }
}
