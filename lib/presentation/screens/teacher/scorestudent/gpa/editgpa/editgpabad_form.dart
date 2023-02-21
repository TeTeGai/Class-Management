import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../../configs/router.dart';
import '../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../utils/snackbar.dart';
import 'package:intl/intl.dart';

import 'gpa_addwidget.dart';
class EditGpaBadForm extends StatefulWidget {

  const EditGpaBadForm({Key? key,}) : super(key: key);

  @override
  State<EditGpaBadForm> createState() => _EditGpaBadFormState();
}

class _EditGpaBadFormState extends State<EditGpaBadForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text('Chỉnh sửa điểm cần cải thiện',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
      ),
      body: BlocBuilder<ScoreBloc,ScoreState>(
        bloc: ScoreBloc()..add(GPABadLoad()),
        buildWhen: (previous, current) => current is GPABadLoaded,
            builder: (context, state) {
              if (state is GPALoading)
              {
                return Center(child: CircularProgressIndicator());
              }
              if(state is GPABadLoaded)
              {
                var gpamodel = state.gpaModel;
                return Stack(
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
                             return GPAAddWidget(GoodOrBad: "Bad",);
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
                                                List lis = ['Bad',gpamodel[index-1]];
                                                Navigator.of(context).pushNamed(AppRouter.EDITGPA,arguments:lis );
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
                                                            color: Colors.red,
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
                    ) :GPAAddWidget(GoodOrBad: "Bad",)
                  ],
                );
              }
              if(state is ScoreLoadFail) { Text("Sai");}
              return Center();
            },


      ),
    );
  }
}

