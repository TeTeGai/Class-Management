import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../utils/snackbar.dart';
import '../../../../../common_blocs/student/bloc.dart';


class AddStudentHeader extends StatefulWidget {
  const AddStudentHeader({Key? key}) : super(key: key);

  @override
  State<AddStudentHeader> createState() => _AddStudentHeaderState();
}

class _AddStudentHeaderState extends State<AddStudentHeader> {
  late StudentBloc addStudentBloc ;
  TextEditingController namecontroller = TextEditingController();
  @override
  void initState() {
    addStudentBloc= BlocProvider.of<StudentBloc>(context);
    super.initState();
  }

  Future<void> onCreate() async {
    if(namecontroller.text.trim().isNotEmpty)
      {
        try
        {
          addStudentBloc.add(
              AddStudent(namecontroller.text)
          );
          MySnackBar.error(message: "Đã thêm học sinh", color: Colors.cyan, context: context,);
          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          //       duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
          // });
        }catch(e)
        {
          MySnackBar.error(message: "Đã có lỗi xảy ra vui lòng thử lại", color: Colors.red, context: context,);
        }

      }
    else if (namecontroller.text.trim().isEmpty)
      {
        MySnackBar.error(message: "Chưa nhập tên học sinh", color: Colors.red, context: context,);
      }
    else
      {
        MySnackBar.error(message: "Đã có lỗi sảy ra", color: Colors.red, context: context,);
      }
  }

  @override
  Widget build(BuildContext context) {

              return Column(
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 34.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 80.w,
                              child: TextFormField(
                                controller: namecontroller,
                                // onChanged: (value) {
                                //   signUpBloc.add(EmailChange(email: value));
                                // },
                                // validator: (_) {
                                //   return !signUpBloc.state.isEmailValid ? "Email chưa hợp lệ" :null;
                                // },
                                autovalidateMode: AutovalidateMode.always,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  labelText: "Họ và tên",
                                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey.shade400)
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.teal)
                                  ),

                                ),
                              ),
                            ),
                            IconButton(onPressed: onCreate, icon: Icon(Icons.add))
                          ],
                        ),
                      ),

                    ],

                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Text("Danh sách học sinh trong lớp",style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.w500),),
                  SizedBox(
                    height: 2.h,
                  ),

                ],

              );
            }


}

