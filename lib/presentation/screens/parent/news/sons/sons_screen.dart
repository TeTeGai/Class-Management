import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/widget/son_addwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../configs/router.dart';
import '../../../../common_blocs/student/bloc.dart';

class SonsScreen extends StatefulWidget {

  const SonsScreen({Key? key,}) : super(key: key);

  @override
  State<SonsScreen> createState() => _SonsScreenState();
}

class _SonsScreenState extends State<SonsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc()..add(LoadSons()),
      child: BlocBuilder<StudentBloc,StudentState>(
        builder: (context, state) {
          if (state is LoadingStudent)
          {
            Text("Sai");
          }
          if(state is LoadedSons)
          {
            var studentModel = state.studentModel;
            return Stack(
              children: [
                studentModel.length>0 ? Container(
                  height: 15.h,
                  width: 100.w,
                  child: ListView.builder(
                    key: UniqueKey(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: studentModel.length +1,
                    itemBuilder: (context, index) {
                      if (index == 0)
                      {
                        return SonAddWidget();
                      }
                      return Container(
                        child: Padding(
                            padding: const EdgeInsets.only(left: 5,top: 10),
                            child: TextButton(
                                onPressed: (){
                                  Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.SONINFOR,arguments:studentModel[index - 1] );
                                },
                                child:  Container(
                                  child: Column(
                                    children: [
                                      Stack(
                                          children: [
                                            CircleAvatar(
                                              // backgroundColor: Color(0xff00A3FF),
                                              backgroundImage: NetworkImage(studentModel[index - 1].avatar),
                                              radius: 25.sp,
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
                                              ]
                                          ]
                                      ),
                                      SizedBox(width: 10,),
                                      ConstrainedBox(
                                          constraints: BoxConstraints(maxWidth: 400),
                                          child: Text(studentModel[index - 1].name,  maxLines: 2,
                                            style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),)
                                      ),
                                    ],
                                  ),
                                )
                            )
                        ),
                      );
                    },
                  ),
                ): SonAddWidget()
              ],
            );
          }
          if(state is LoadFailStudent) { Text("Sai");}
          return Center();
        },


      ),
    );
  }
}
