import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/score/editscore/score_addwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/model/student_model.dart';
import '../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../utils/snackbar.dart';



class EditScoreDetailForm extends StatefulWidget {
  const EditScoreDetailForm({Key? key}) : super(key: key);

  @override
  State<EditScoreDetailForm> createState() => _EditScoreDetailFormState();
}

class _EditScoreDetailFormState extends State<EditScoreDetailForm> {



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
            child: Text('Chỉnh sửa điểm',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
        bloc: ScoreBloc()..add(ScoreLoad()),
        buildWhen: (previous, current) => current is ScoreLoaded,
        builder: (context, state) {
          if (state is ScoreLoading)
          {
            return Center(child: CircularProgressIndicator());
          }
          if(state is ScoreLoaded)
          {
            var scoreModel = state.scoreModel;
            return Stack(
              children: [
                scoreModel.length>0 ? AnimationLimiter(
                  child: GridView.builder(
                    gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,childAspectRatio: (3 / 2),
                    ),
                    key: UniqueKey(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: scoreModel.length +1,
                    itemBuilder: (context, index) {
                      if (index == 0)
                      {
                        return ScoreAddWidget();
                      }
                      return AnimationConfiguration.staggeredGrid(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        columnCount: 3,
                        child: ScaleAnimation(
                          child: FadeInAnimation(
                            child: Container(
                              child: Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: TextButton(
                                    onPressed: (){
                                      Navigator.of(context).pushNamed(AppRouter.EDITSCORESCREEN,arguments: scoreModel[index - 1]);
                                    },
                                      child:  Container(
                                        width: 45.w,
                                        height: 12.h,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1,color: Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                                        ),
                                        child: Row(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(width: 10,),
                                            CircleAvatar(radius: 25.sp,
                                              backgroundImage: AssetImage(scoreModel[index - 1].avatar),
                                              backgroundColor: Colors.white,
                                            ),
                                            SizedBox(width: 10,),
                                            ConstrainedBox(
                                                constraints: BoxConstraints(maxWidth: 20.w),
                                                child: Text(scoreModel[index - 1].title, maxLines: 2,
                                                    style: TextStyle(fontSize: 15.sp,color: Colors.black),textAlign: TextAlign.center)
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
                ) :ScoreAddWidget()
              ],
            );
          }
          if(state is ScoreLoadFail) { }
          return Center();
        },
      ),
    );
  }

}

