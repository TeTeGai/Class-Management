import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/screens/teacher/student/widget/student_addwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../../../../../configs/router.dart';
import '../../../../common_blocs/student/bloc.dart';



class StudentWidget extends StatefulWidget {
  final ClassModel classModel;
  const StudentWidget({Key? key, required this.classModel}) : super(key: key);

  @override
  State<StudentWidget> createState() => _StudentWidgetState();
}

class _StudentWidgetState extends State<StudentWidget> with AutomaticKeepAliveClientMixin<StudentWidget> {

  @override
  void initState() {
     BlocProvider.of<StudentBloc>(context).add(LoadStudent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc,StudentState>(
          buildWhen: (previous, current) => current is LoadedStudent,
          builder: (context, state) {
            if (state is LoadingStudent)
            {
             return Center(child: CircularProgressIndicator());
            }
            if(state is LoadedStudent)
            {
              var studentModel = state.studentModel;
              if(widget.classModel.leader == FirebaseAuth.instance.currentUser!.uid)
              {
                return Stack(
                  children: [
                    studentModel.length>0 ? AnimationLimiter(
                      child: GridView.builder(
                        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisExtent: 20.h,
                          crossAxisSpacing: 5.w,

                        ),
                        key: UniqueKey(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: studentModel.length +1,
                        itemBuilder: (context, index) {

                          if (index == 0)
                          {
                            return StudentAddWidget();
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
                                          style: ButtonStyle(
                                            overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                                          ),
                                          onPressed: (){
                                            Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.SCORESTUDENT,arguments:[studentModel[index - 1],widget.classModel] );
                                          },
                                          child:  Container(
                                            child: Stack(
                                              children: [
                                                Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    CircleAvatar(
                                                      backgroundImage: NetworkImage(studentModel[index - 1].avatar),
                                                      radius: 25.4.sp,
                                                    ),
                                                    SizedBox(height: 0.6.h,),


                                                    ConstrainedBox(
                                                        constraints: BoxConstraints(maxWidth: 100.w),
                                                        child: Text(studentModel[index - 1].name,  maxLines: 2,
                                                          style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400,),textAlign: TextAlign.center,)
                                                    ),

                                                  ],
                                                ),
                                                if(studentModel[index - 1].score <0)
                                                  ... [
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
                                                          child: Text(studentModel[index - 1].score.toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                        )
                                                    )
                                                  ]
                                                else if(studentModel[index - 1].score >0)
                                                  ... [
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
                                                          child: Text(studentModel[index - 1].score.toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                        )
                                                    )
                                                  ],
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
                    ) :StudentAddWidget()

                  ],
                );
              }
              else
                {
                  return Stack(
                    children: [
                      studentModel.length>0 ? AnimationLimiter(
                        child: GridView.builder(
                          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 20.h,
                            crossAxisSpacing: 5.w,

                          ),
                          key: UniqueKey(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: studentModel.length,
                          itemBuilder: (context, index) {
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
                                            style: ButtonStyle(
                                              overlayColor: MaterialStateColor.resolveWith((states) => Colors.transparent),
                                            ),
                                            onPressed: (){
                                              Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.SCORESTUDENT,arguments:[studentModel[index],widget.classModel] );
                                            },
                                            child:  Container(
                                              child: Stack(
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage(studentModel[index].avatar),
                                                        radius: 25.4.sp,
                                                      ),
                                                      SizedBox(height: 0.6.h,),


                                                      ConstrainedBox(
                                                          constraints: BoxConstraints(maxWidth: 100.w),
                                                          child: Text(studentModel[index].name,  maxLines: 2,
                                                            style: TextStyle(fontSize: 16.sp,color: Colors.black,fontWeight: FontWeight.w400,),textAlign: TextAlign.center,)
                                                      ),

                                                    ],
                                                  ),
                                                  if(studentModel[index].score <0)
                                                    ... [
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
                                                            child: Text(studentModel[index].score.toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                          )
                                                      )
                                                    ]
                                                  else if(studentModel[index].score >0)
                                                    ... [
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
                                                            child: Text(studentModel[index].score.toString(),style: TextStyle(fontSize: 15.sp,color: Colors.white),),
                                                          )
                                                      )
                                                    ],
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
                      ) :Center()

                    ],
                  );
                }

            }
            if(state is LoadFailStudent) { Text("Sai");}
            return Center();
          },

  
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

