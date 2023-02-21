import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';
import '../../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../../utils/snackbar.dart';
import '../addgpason/gpason_addwidget.dart';
import '../editgpason/gpason_editwidget.dart';

class GpaBadSonForm extends StatefulWidget {
  final StudentModel studentModel;
  const GpaBadSonForm({Key? key, required this.studentModel,}) : super(key: key);

  @override
  State<GpaBadSonForm> createState() => _GpaBadSonFormState();
}

class _GpaBadSonFormState extends State<GpaBadSonForm> {
  var currentdate = DateTime.now();
  late String nameUser;
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  void initState() {

    userAuthRepository.getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
      nameUser = value.sex +" "+ value.firstName + " " + value.lastName;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc,ScoreState>(
      bloc: ScoreBloc()..add(GPABadSonLoad()),
          builder: (context, state) {
            if (state is GPALoading)
            {
              Text("Sai");
            }
            if(state is GPABadSonLoaded)
            {
              var gpamodel = state.gpaModel;
              return Stack(
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
                           return GPASonEditWidget(GoodOrBad: "Bad",isConnect: widget.studentModel.isConnect);
                          }
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          columnCount: 3,

                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: Container(
                                    child: TextButton(
                                        onPressed: (){
                                          if(widget.studentModel.isConnect)
                                          {
                                            var day =DateFormat('dd/MM/yyyy').format(currentdate);
                                            MySnackBar.error(message: widget.studentModel.name+" đã bị trừ "+ gpamodel[index - 1].score.toString() + " điểm do "+gpamodel[index - 1].title, color: Colors.red, context: context);
                                            ScoreBloc().add(GpaHomeListAdd(widget.studentModel.classId!,gpamodel[index - 1].title, gpamodel[index - 1].score,
                                                "",day,widget.studentModel.idStudent!,nameUser,gpamodel[index - 1].avatar,gpamodel[index - 1].category));
                                          }
                                          else
                                          {
                                            MySnackBar.error(message: "Vui lòng kết nối tới lớp học", color: Colors.red, context: context);
                                          }
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
                                                  ConstrainedBox(
                                                      constraints: BoxConstraints(maxWidth: 400),
                                                      child: Text(gpamodel[index - 1].title,  maxLines: 2,
                                                          style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.w400,color: Colors.black,),textAlign: TextAlign.center)
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
                        );
                      },
                    ),
                  ) :GPASonEditWidget(GoodOrBad: "Bad",isConnect: widget.studentModel.isConnect)
                ],
              );
            }
            if(state is GPALoadFail) { Text("Sai");}
            return Center();
          },

  
    );
  }
}

