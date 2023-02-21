import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../utils/pushnotifications.dart';
import '../../../../../../utils/snackbar.dart';
import '../editgpa/gpa_addwidget.dart';
import 'package:intl/intl.dart';

import 'gpa_editwidget.dart';
class GpaGoodForm extends StatefulWidget {
  final StudentModel studentModel;
  final String? pushToken;
  const GpaGoodForm({Key? key, required this.studentModel, this.pushToken,}) : super(key: key);

  @override
  State<GpaGoodForm> createState() => _GpaGoodFormState();
}

class _GpaGoodFormState extends State<GpaGoodForm> with AutomaticKeepAliveClientMixin<GpaGoodForm>{
   late ScoreBloc scoreBloc;
   var currentdate = DateTime.now();
   UserAuthRepository userAuthRepository = new UserAuthRepository();
   late String nameUser;
   @override
  void initState() {
     scoreBloc = BlocProvider.of<ScoreBloc>(context);
     userAuthRepository.getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
       nameUser = value.sex +" "+ value.firstName + " " + value.lastName;
     });
    super.initState();
  }
  @override
  void dispose() {
    scoreBloc.close();
    // TODO: implement dispose
    super.dispose();
  }
   void onPress(score,title,img,category)
   {
     var day =DateFormat('dd/MM/yyyy').format(currentdate);
     // var day =Timestamp.now();
     MySnackBar.error(message: widget.studentModel.name+" đã được cộng "+ score.toString() + " điểm do "+title, color: Colors.cyan, context: context);
   if(widget.pushToken!= "")
     {
       PushNotifications.callOnFcmApiSendPushNotifications(
           body:  widget.studentModel.name+" đã được cộng "+ score.toString() + " điểm do "+title,
           To: widget.pushToken!);
     }

     scoreBloc.add(GPAStudentUpdateModel(score, widget.studentModel.id,widget.studentModel.name+" đã được cộng "+ score.toString() + " điểm do "+title +" được gửi bởi "+nameUser,widget.studentModel.idParent));
     scoreBloc.add(GpaListAdd(title, score,
         "",day,widget.studentModel.id,nameUser,img,category));
   }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc,ScoreState>(
      buildWhen: (previous, current) => current is GPAGoodLoaded,
          builder: (context, state) {
            if (state is GPALoading)
            {
              return Center(child: CircularProgressIndicator());
            }
            if(state is GPAGoodLoaded)
            {
              var gpamodel = state.gpaModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: Text("Tích cực",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold)),
                  ),
                  Stack(
                    children: [
                      gpamodel.length>0 ? AnimationLimiter(
                        child: GridView.builder(
                          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 19.h,
                          ),
                          key: UniqueKey(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: gpamodel.length +1,
                          itemBuilder: (context, index) {
                            if (index == 0)
                              {
                               return GPAEditWidget(GoodOrBad: "Good",);
                              }
                                return AnimationConfiguration.staggeredGrid(
                                  position: index,
                                  duration: const Duration(milliseconds: 375),
                                  columnCount: 3,
                                  child: ScaleAnimation(
                                    child: FadeInAnimation(
                                      child: Container(
                                        child: Padding(
                                            padding: const EdgeInsets.only(left: 5,top: 10),
                                            child: TextButton(
                                                onPressed: (){
                                                  onPress(gpamodel[index - 1].score,gpamodel[index - 1].title,gpamodel[index - 1].avatar,gpamodel[index - 1].category);
                                                  },
                                                child:  Container(
                                                  child: Stack(
                                                    children: [
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        children: [
                                                          Container(
                                                            child: CircleAvatar(radius: 25.4.sp,
                                                              backgroundColor: Colors.white,
                                                              backgroundImage: AssetImage(gpamodel[index - 1].avatar),
                                                            ),
                                                          ),
                                                          SizedBox(height: 0.6.h,),
                                                          ConstrainedBox(
                                                              constraints: BoxConstraints(maxWidth: 100.w),
                                                              child: Text(gpamodel[index - 1].title,  maxLines: 2,
                                                                style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400,),textAlign: TextAlign.center,)
                                                          ),

                                                        ],
                                                      ),
                                                      Positioned(
                                                          right: 0,
                                                          top: 0,
                                                          child: Container(
                                                            padding: EdgeInsets.all(7.5),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(
                                                                  width: 2,
                                                                  color: Colors.white
                                                              ),
                                                              borderRadius: BorderRadius.circular(100.0),
                                                              color: Colors.blueAccent,
                                                            ),
                                                            child: Text(gpamodel[index - 1].score.toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                          },
                        ),
                      ) :GPAEditWidget(GoodOrBad: "Good",)
                    ],
                  ),
                ],
              );
            }
            if(state is ScoreLoadFail) { Text("Sai");}
            return Center();
          },

  
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

