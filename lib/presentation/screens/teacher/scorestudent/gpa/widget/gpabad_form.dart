import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../utils/pushnotifications.dart';
import '../../../../../../utils/snackbar.dart';
import '../editgpa/gpa_addwidget.dart';
import 'gpa_editwidget.dart';

class GpaBadForm extends StatefulWidget {
  final StudentModel studentModel;
  final String? pushToken;
  const GpaBadForm({Key? key, required this.studentModel, this.pushToken,}) : super(key: key);

  @override
  State<GpaBadForm> createState() => _GpaBadFormState();
}

class _GpaBadFormState extends State<GpaBadForm> with AutomaticKeepAliveClientMixin<GpaBadForm>{

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
    super.dispose();
  }
  void onPress(score,title,img,category)
  {
    // Timestamp.now().nanoseconds;
    // Timestamp.now().microsecondsSinceEpoch;
    var day =DateFormat('dd/MM/yyyy').format(currentdate);
    // var day =Timestamp.now();
    MySnackBar.error(message: widget.studentModel.name +" đã bị trừ "+ score.toString() + " điểm do "+title, color: Colors.red, context: context);
    if(widget.pushToken!= "")
    {
      PushNotifications.callOnFcmApiSendPushNotifications(
          body:  widget.studentModel.name+" đã bị trừ "+ score.toString() + " điểm do "+title,
          To: widget.pushToken!);
    }

    scoreBloc.add(GPAStudentUpdateModel(score, widget.studentModel.id,widget.studentModel.name+" đã bị trừ "+ score.toString() + " điểm do "+title+" được gửi bởi "+nameUser,widget.studentModel.idParent));
    scoreBloc.add(GpaListAdd(title, score,
        "",day,widget.studentModel.id,nameUser,img,category));
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc,ScoreState>(
      buildWhen: (previous, current) => current is GPABadLoaded,
          builder: (context, state) {
            if (state is GPALoading)
            {
              return Center(child: CircularProgressIndicator());
            }
            if(state is GPABadLoaded)
            {
              var gpamodel = state.gpaModel;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20),
                    child: Text("Cần cải thiện",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.bold)),
                  ),
                  Stack(
                    children: [
                      gpamodel.length>0 ? AnimationLimiter(
                        child: GridView.builder(
                          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                          ),
                          key: UniqueKey(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: gpamodel.length +1,
                          itemBuilder: (context, index) {
                            if (index == 0)
                              {
                               return GPAEditWidget(GoodOrBad: "Bad",);
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
                                                child:  Stack(
                                                  children: [
                                                    Container(
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.center,

                                                        children: [
                                                          CircleAvatar(radius: 25.4.sp,
                                                            backgroundColor: Colors.white,
                                                            backgroundImage: AssetImage(gpamodel[index - 1].avatar),
                                                          ),
                                                          SizedBox(height: 0.6.h,),
                                                          ConstrainedBox(
                                                              constraints: BoxConstraints(maxWidth: 400),
                                                              child: Text(gpamodel[index - 1].title,  maxLines: 2,
                                                                style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400,),textAlign: TextAlign.center)
                                                          ),
                                                        ],
                                                      ),
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
                                                            color: Colors.red,
                                                          ),
                                                          child: Text(gpamodel[index - 1].score.toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                        )
                                                    ),
                                                  ],
                                                )
                                            )
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                          },
                        ),
                      ) :GPAEditWidget(GoodOrBad: "Bad",)
                    ],
                  ),
                ],
              );
            }
            if(state is GPALoadFail) { Text("Sai");}
            return Center();
          },

  
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

