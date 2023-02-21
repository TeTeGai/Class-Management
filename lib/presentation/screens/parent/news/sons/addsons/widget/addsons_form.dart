import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/data/model/student_model.dart';
import 'package:luan_an/data/repository/repository.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/addsons/bloc/addsons_bloc.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/addsons/bloc/addsons_event.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../../data/model/gpa_model.dart';
import '../../../../../../../utils/image.dart';
import '../../../../../../../utils/snackbar.dart';

class AddSonForm extends StatefulWidget {
  const AddSonForm({Key? key}) : super(key: key);

  @override
  State<AddSonForm> createState() => _AddSonFormState();
}

class _AddSonFormState extends State<AddSonForm> {
  late AddSonsBloc addSonsBloc;
  var user = FirebaseAuth.instance.currentUser;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  Uint8List? _file ;
  late String nameUser;
  late String phoneUser;
  @override
  void initState() {
    userAuthRepository.getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
      nameUser = value.firstName + " " + value.lastName;
      phoneUser = value.phoneNumber;
    });
    addSonsBloc = BlocProvider.of<AddSonsBloc>(context);
    super.initState();
  }
  Future<void> AddInitGPA() async{
    var _scorecollection = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("gpa");
    GPAModel gpaModel1 = new GPAModel(id: "id1", title: "Rửa bát giúp mẹ", avatar: "assets/student.png", score: 10, category: "GoodGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel2 = new GPAModel(id: "id2", title: "Phụ giúp việc nhà", avatar: "assets/finance.png", score: 10, category: "GoodGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel3 = new GPAModel(id: "id3", title: "Ngoan ngoãn vâng lời", avatar: "assets/flower.png", score: 10, category: "GoodGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel4 = new GPAModel(id: "id4", title: "Không tự giác học bài", avatar: "assets/protest.png", score: -10, category: "BadGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel5= new GPAModel(id: "id5", title: "Dậy muộn", avatar: "assets/zzz.png", score: -10, category: "BadGPA",timeCreate: Timestamp.now());
    GPAModel gpaModel6 = new GPAModel(id: "id6", title: "Chơi game", avatar: "assets/sword.png", score: -10, category: "BadGPA",timeCreate: Timestamp.now());
    _scorecollection.get().then((value) async {
      if(value.docs.isEmpty)
        {
          await _scorecollection.doc(gpaModel1.id).set(gpaModel1.toMap());
          await _scorecollection.doc(gpaModel2.id).set(gpaModel2.toMap());
          await _scorecollection.doc(gpaModel3.id).set(gpaModel3.toMap());
          await _scorecollection.doc(gpaModel4.id).set(gpaModel4.toMap());
          await _scorecollection.doc(gpaModel5.id).set(gpaModel5.toMap());
          await _scorecollection.doc(gpaModel6.id).set(gpaModel6.toMap());
        }
    });
  }
  void onCreate(){
    var id = const Uuid().v1();
    if(firstNameController.text.trim().isNotEmpty && lastNameController.text.trim().isNotEmpty)
      {
        if( _file != null)
        {
          StudentModel studentModel = StudentModel(
            id: id,
            idStudent: "",
            name: firstNameController.text.trim() +" "+ lastNameController.text.trim() ,
            avatar: '_file',
            idParent: FirebaseAuth.instance.currentUser!.uid,
            score: 0,
            time: Timestamp.now(),
            isConnect: false,
          );
          try{
            addSonsBloc.add(
                AddSons(studentModel,_file!,'')
            );
            Navigator.of(context).pop();
            MySnackBar.error(message: "Tạo thông tin con thành công",color: Colors.cyan, context: context);
          }
          catch(e)
          {
            MySnackBar.error(message: "Có gì đó sai sai vui lòng thử lại sau",color: Colors.red, context: context);

          }
          AddInitGPA();

        }
        else
        {
          StudentModel studentModel = StudentModel(
            id: id,
            idStudent: "",
            name: firstNameController.text.trim() +" "+ lastNameController.text.trim() ,
            avatar: 'https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Favatar%2F31818797506_41e52a8b36.jpg?alt=media&token=18cff330-c239-4025-bf44-befd5216dde2',
            idParent: FirebaseAuth.instance.currentUser!.uid,
            score: 0,
            time: Timestamp.now(),
            isConnect: false,
          );


          try{
            addSonsBloc.add(
                AddSons(studentModel,null,'https://firebasestorage.googleapis.com/v0/b/classapp-f7ed3.appspot.com/o/img%2Favatar%2F31818797506_41e52a8b36.jpg?alt=media&token=18cff330-c239-4025-bf44-befd5216dde2')
            );
            Navigator.of(context).pop();
            MySnackBar.error(message: "Tạo thông tin con thành công",color: Colors.blue, context: context);
          }
          catch(e)
          {
            MySnackBar.error(message: "Có gì đó sai sai vui lòng thử lại sau",color: Colors.red, context: context);

          }
          AddInitGPA();

        }
      }
    else
      {
        MySnackBar.error(message: "Chưa nhập đủ thông tín",color: Colors.red, context: context);
      }

  }

  @override
  Widget build(BuildContext context) {
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
              child: firstNameInput(),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
              child: lastNameInput(),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 50,
                onPressed: () {
                  try{
                    onCreate();

                  }catch(e)
                  {

                  }
                },
                color: Colors.cyan,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)
                ),
                child: Text("Thêm lớp", style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white
                ),),
              ),
            ),
          ],
        );
      }
  Widget firstNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: firstNameController,
          decoration: InputDecoration(
            labelText: "Họ" + " (*)",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }



  Widget lastNameInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextField(
          controller: lastNameController,
          decoration: InputDecoration(
            labelText: "Tên" + " (*)",
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          ),
        ),
        SizedBox(height: 20,),
      ],
    );
  }

  _selectImg(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20.sp),
            child: Text(("Chụp ảnh")),
            onPressed: () async {
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
            onPressed: () async {
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


