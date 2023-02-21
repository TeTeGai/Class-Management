
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/profile_bloc.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/widget/classselect_form.dart';
import 'package:luan_an/presentation/screens/teacher/classselect/widget/classselect_header.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../configs/router.dart';
import 'bloc/bloc.dart';



class ClassSelectScreen extends StatelessWidget {

  const ClassSelectScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ProfileBloc(),),
          BlocProvider(create: (context) => ClassSelectBloc(),),
        ],
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            brightness: Brightness.light,
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                ClassSelectHeader(),
                ClassSelectForm(),
                    Padding(
                        padding: const EdgeInsets.only(left: 10,top: 10),
                        child: TextButton(onPressed: ()=> Navigator.pushNamed(context, AppRouter.ADDCLASS), child:  Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start ,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 22.4.sp,
                              child:
                              CircleAvatar(radius: 22.sp,
                                backgroundColor: Colors.cyan,
                                child:  Center(child: Icon(Icons.add,size: 30.sp,color: Colors.white,),),
                              ),
                            ),
                            SizedBox(width: 2.w,),
                            Text("Thêm mới",style: TextStyle(fontSize: 17.sp,color: Colors.cyan)),
                          ],
                        ),)
                    ),
                Padding(
                    padding: const EdgeInsets.only(left: 10,top: 10),
                    child: TextButton(onPressed: ()=> Navigator.pushNamed(context, AppRouter.JOINCLASS), child:  Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start ,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                          radius: 22.4.sp,
                          child:
                          CircleAvatar(radius: 22.sp,
                            backgroundColor: Colors.cyan  ,
                            child:  Center(child: Icon(Icons.person_pin,size: 30.sp,color: Colors.white,),),
                          ),
                        ),
                        SizedBox(width: 2.w,),
                        Text("Tham gia vào lớp",style: TextStyle(fontSize: 17.sp,color: Colors.cyan)),
                      ],
                    ),)
                ),
                 Center(
                      child: SizedBox(
                        width: 100.w,
                        child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, AppRouter.HELP);
                          },
                          child: Text("Trợ giúp",style: TextStyle(fontSize: 17.sp,color: Colors.cyan),),
                        ),
                      ),
                    )

              ],
            ),
          ),
        ),
      ),);
  }
}