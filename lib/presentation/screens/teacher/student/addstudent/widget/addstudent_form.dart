import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../configs/router.dart';
import '../../../../../common_blocs/student/bloc.dart';





class AddStudentForm extends StatefulWidget {
  const AddStudentForm({Key? key}) : super(key: key);

  @override
  State<AddStudentForm> createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentForm> {
  late StudentBloc studentBloc;
  @override
  void initState() {
    BlocProvider.of<StudentBloc>(context).add(LoadStudent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentBloc,StudentState>(
          builder: (context, state) {
            if (state is LoadingStudent)
            {
              Text("Sai");
            }
            if(state is LoadedStudent)
            {


              var studentModel = state.studentModel;

              return Stack(
                children: [
                  studentModel.length>0 ? SingleChildScrollView(
                    reverse: true,
                    child: ListView.builder(
                        key: UniqueKey(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: studentModel.length,
                        itemBuilder: (context, index) {
                          return  Padding(
                            padding: const EdgeInsets.only(top: 8.0,bottom: 8),
                            child: MaterialButton(
                              onPressed:(){
                                Navigator.of(context).pushNamed(AppRouter.EDITSTUDENT,arguments:[studentModel[index],"Student"] );
                              },
                              child: Container(
                                width: 90.w,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(radius: 22.sp, backgroundImage: NetworkImage(studentModel[index].avatar),),
                                    SizedBox(width: 5.w,),
                                    SizedBox(
                                      width: 65.w,
                                      child: Text(studentModel[index].name,maxLines: 2,),
                                    ),
                                     Icon(Icons.edit,size: 20.sp,)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                    ),

                  ):Center()

                ],
              );

            }
            if(state is LoadFailStudent) { }
            return Container();
          },

    );

  }

}

