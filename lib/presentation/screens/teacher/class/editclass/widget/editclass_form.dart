import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../utils/image.dart';
import '../../../../../../utils/snackbar.dart';
import '../bloc/bloc.dart';
class EditClassForm extends StatefulWidget {
  final ClassModel classModel;
  const EditClassForm({Key? key, required this.classModel}) : super(key: key);

  @override
  State<EditClassForm> createState() => _EditClassFormState();
}

class _EditClassFormState extends State<EditClassForm> {
  late EditClassBloc editClassBloc;
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController classController = TextEditingController();
  TextEditingController schoolController = TextEditingController();
   Uint8List? _file ;
  late String grade = "Mầm non";
  @override
  void initState() {
    editClassBloc = BlocProvider.of<EditClassBloc>(context);
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    classController.clear();
    schoolController.clear();
    super.dispose();
  }
  void onCreate(){
    if(classController.text.trim().isNotEmpty && schoolController.text.trim().isNotEmpty)
      {
        if(_file != null)
        {
          ClassModel classModel = ClassModel(
              id: widget.classModel.id,
              leader: '',
              members: [],
              className: classController.text.trim(),
              gradeName: grade,
              schoolName: schoolController.text.trim(),
              avatar: "",
              timeCreate: widget.classModel.timeCreate);
          ClassModel initModel = classModel.cloneWith();
          editClassBloc.add(
              Submit(initModel,_file!,'')
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          MySnackBar.error(message: "Cập nhật thành công",color: Colors.cyan, context: context);
        }
        else
        {
          ClassModel classModel = ClassModel(
              id: widget.classModel.id,
              leader: '',
              members: [],
              className: classController.text,
              gradeName: grade,
              schoolName: schoolController.text,
              avatar: "",
              timeCreate: widget.classModel.timeCreate);
          ClassModel initModel = classModel.cloneWith();
          editClassBloc.add(
              Submit(initModel,null,'https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Fsunflower.png?alt=media&token=de5391d0-4798-4a0f-b59b-757ca661242b')
          );
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          MySnackBar.error(message: "Cập nhật thành công",color: Colors.cyan, context: context);
        }
      }
    else{
      MySnackBar.error(message: "Chưa nhập đủ thông tin", color: Colors.red, context: context);
    }

}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EditClassBloc,EditClassState>(
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
                    child: classInput(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: gradeInput(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
                    child: schoolInput(),
                  ),
                  SizedBox(height: 1.h,),
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
                      child: Text("Chỉnh sửa thông tin lớp ", style: TextStyle(
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

  Widget classInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: classController,
          decoration: InputDecoration(
            labelText: "Lớp" + " (*)",
            hintText: widget.classModel.className,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  Widget gradeInput() {
    return DropdownSearch<String>(
      popupProps: PopupProps.modalBottomSheet(
        modalBottomSheetProps: ModalBottomSheetProps(
          constraints: BoxConstraints(
            maxHeight: 400,
          ),
          barrierDismissible: true,
        ),
        showSelectedItems: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Cấp", style: TextStyle(fontSize: 23.sp),),
          ],
        ),
      ),
      items: ["Mầm non", "Tiểu học", "Trung học cơ sở", 'Trung học phổ thông','Khác'],
      onChanged: (value) {
        setState(() {
          grade = value.toString();
        });

      },

      selectedItem: grade = widget.classModel.gradeName,

    );
  }

  Widget schoolInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: schoolController,
          decoration: InputDecoration(
            labelText: "Trường" + " (*)",
            hintText: widget.classModel.schoolName,
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
