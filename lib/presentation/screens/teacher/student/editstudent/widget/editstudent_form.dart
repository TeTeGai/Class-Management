import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../utils/image.dart';
import '../../../../../../utils/snackbar.dart';
import '../bloc/bloc.dart';
class EditStudentForm extends StatefulWidget {
  final StudentModel studentModel;
  final String sonOrStudent;

  const EditStudentForm({Key? key, required this.studentModel, required this.sonOrStudent}) : super(key: key);

  @override
  State<EditStudentForm> createState() => _EditStudentFormState();
}

class _EditStudentFormState extends State<EditStudentForm> {
  late EditStudentBloc editClassBloc;
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController nameController = TextEditingController();
   Uint8List? _file ;
  @override
  void initState() {
    editClassBloc = BlocProvider.of<EditStudentBloc>(context);
    super.initState();
  }
  @override
  void dispose() {
    nameController.clear();
    super.dispose();
  }
  void onCreate(){
    if(nameController.text.trim().isNotEmpty )
      {
        if(widget.sonOrStudent == "Student")
          {
            if(_file != null)
            {
              StudentModel studentModel = StudentModel(
                  id:  widget.studentModel.id,
                  name: nameController.text.trim(),
                  avatar: '',
                  idParent:'' ,
                  score: widget.studentModel.score,
                  time: widget.studentModel.time,
                  isConnect:  widget.studentModel.isConnect);
              StudentModel initModel = studentModel.cloneWith();
              editClassBloc.add(
                  Submit(initModel,_file!,'')
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              MySnackBar.error(message: "Cập nhật thành công",color: Colors.cyan, context: context);
            }
            else
            {
              StudentModel studentModel = StudentModel(
                  id:  widget.studentModel.id,
                  name: nameController.text.trim(),
                  avatar: '',
                  idParent:'' ,
                  score: widget.studentModel.score,
                  time: widget.studentModel.time,
                  isConnect:  widget.studentModel.isConnect);
              StudentModel initModel = studentModel.cloneWith();
              editClassBloc.add(
                  Submit(initModel,null,widget.studentModel.avatar)
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              MySnackBar.error(message: "Cập nhật thành công",color: Colors.cyan, context: context);
            }
          }
        else if (widget.sonOrStudent == "Son")
          {
            if(_file != null)
            {
              StudentModel studentModel = StudentModel(
                  id:  widget.studentModel.id,
                  name: nameController.text.trim(),
                  avatar: '',
                  idParent:'' ,
                  score: widget.studentModel.score,
                  time: widget.studentModel.time,
                  isConnect:  widget.studentModel.isConnect);
              StudentModel initModel = studentModel.cloneWith();
              editClassBloc.add(
                  ParentSubmit(initModel,_file!,'')
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              MySnackBar.error(message: "Cập nhật thành công",color: Colors.cyan, context: context);
            }
            else
            {
              StudentModel studentModel = StudentModel(
                  id:  widget.studentModel.id,
                  name: nameController.text.trim(),
                  avatar: '',
                  idParent:'' ,
                  score: widget.studentModel.score,
                  time: widget.studentModel.time,
                  isConnect:  widget.studentModel.isConnect);
              StudentModel initModel = studentModel.cloneWith();
              editClassBloc.add(
                  ParentSubmit(initModel,null,widget.studentModel.avatar)
              );
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              MySnackBar.error(message: "Cập nhật thành công",color: Colors.cyan, context: context);
            }
          }

      }
    else{
      MySnackBar.error(message: "Chưa nhập đủ thông tin", color: Colors.red, context: context);
    }

}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditStudentBloc,EditStudentState>(
          builder: (context, state) {
            return  Column(
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: ()
                      {
                        _selectImg(context);
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.cyan,
                        radius: 36.sp,
                        child: CircleAvatar(radius: 35.sp,
                          backgroundColor: Colors.white,
                          backgroundImage: _file!= null ?MemoryImage(_file!): null,
                          child: _file== null ?Icon(
                            Icons.camera_alt,
                            color: Colors.cyan,
                            size: 40.sp,
                          ): null
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: nameInput(),
                  ),
                  SizedBox(height: 2.h,),
                  Container(
                    width: 85.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border(
                          bottom: BorderSide(color: Colors.black54),
                          top: BorderSide(color: Colors.black54),
                          left: BorderSide(color: Colors.black54),
                          right: BorderSide(color: Colors.black54),
                        )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      onPressed: () {
                          onCreate();
                      },
                      color: Colors.cyan,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("Chỉnh sửa thông tin học sinh ", style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: Colors.white
                      ),),
                    ),
                  )
                ],
            );
          },
    );
  }

  Widget nameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: "Họ tên học sinh" + " (*)",
            hintText: widget.studentModel.name,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }
  _selectImg(BuildContext context) async{
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20.sp),
            child: Text(("Chụp ảnh")),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await PickImg(ImageSource.camera);
              setState(() {
                _file = file;
              });
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20.sp),
            child: Text(("Chọn hình từ thư viện")),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await PickImg(ImageSource.gallery);
              setState(() {
                _file = file;
              });
            },
          ),
        ],
      );
    },);

  }
}
