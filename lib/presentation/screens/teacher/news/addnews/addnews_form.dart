import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../../../../utils/image.dart';
import '../../../../../utils/snackbar.dart';
import 'bloc/bloc.dart';


class AddNewsForm extends StatefulWidget {
  const AddNewsForm({Key? key}) : super(key: key);

  @override
  State<AddNewsForm> createState() => _AddNewsFormState();
}

class _AddNewsFormState extends State<AddNewsForm> {
  late AddNewsBloc addNewsBloc;
  late ProfileBloc profileBloc;
  TextEditingController textEditingController = TextEditingController();
   Uint8List? file8 ;
   List _listFile=[];


   @override
  void dispose() {
     profileBloc.close();
     addNewsBloc.close();
    super.dispose();
  }

  @override
  void initState() {
    addNewsBloc = BlocProvider.of<AddNewsBloc>(context);
    profileBloc =BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }
  Future<void> onCreate(String firstName,String lastName,String avatar,) async {
     if(textEditingController.text.trim().isNotEmpty)
       {
         NewsModel newsModel;
         late NewsModel initModel;
         Timestamp timestamp = Timestamp.now();
         setState(() {
           newsModel = NewsModel(
             id: "",
             classId: "",
             datePost: timestamp,
             text: textEditingController.text,
             idUser: FirebaseAuth.instance.currentUser!.uid,
             postId: "",
             likes: [],
             porfImg: _listFile,
             nameUser: firstName +" "+lastName,
             avatarUser: avatar,
           );
           initModel = newsModel.cloneWith();
         });

         try
         {
           addNewsBloc.add(
               AddNews(initModel,
                   _listFile,
               )
           );
           Navigator.of(context).pop();
           MySnackBar.error(message: "Đã đăng bài thành công", color: Colors.cyan, context: context);

         }
         catch(e)
         {
           MySnackBar.error(message: "Có lỗi gì đó đã xảy ra vui lòng thử lại", color: Colors.red, context: context);
         }
       }
     else{
       MySnackBar.error(message: "Chưa nhập vào nội dung", color: Colors.red, context: context);

     }
  }

  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProfileBloc,ProfileState>(
        builder: (context, stateProfile) {
          if(stateProfile is LoadedProfile)
            {
              return BlocBuilder<AddNewsBloc,AddNewsState>(
                      builder: (context, state) {
                        return Scaffold(
                            backgroundColor: Colors.white,
                            appBar: AppBar(
                              backgroundColor: Colors.transparent,
                              elevation: 0,
                              iconTheme: IconThemeData(color: Colors.black),
                              titleTextStyle: TextStyle(color: Colors.black),
                              title:  ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 400),
                                  child: Text('Thêm tin mới',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
                              ),
                              centerTitle: true,
                              leading: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: MaterialButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
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
                              actions: [
                                TextButton(onPressed: (){
                                  onCreate(
                                      stateProfile.loggedUser.sex +" "+ stateProfile.loggedUser.firstName,
                                      stateProfile.loggedUser.lastName,
                                      stateProfile.loggedUser.avatar
                                  );
                                },
                                    child: Text("Đăng"))
                              ],
                            ),
                            resizeToAvoidBottomInset: false,
                            body: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 25.sp,
                                        backgroundImage: NetworkImage(stateProfile.loggedUser.avatar),
                                      ),
                                      SizedBox(
                                        width: 50.w,
                                        child: TextFormField(
                                          controller: textEditingController,
                                          decoration: InputDecoration(
                                              hintText: "Viết trạng thái",
                                              border: InputBorder.none
                                          ),
                                          maxLines: 8,
                                        ),
                                      ),

                                      Container(
                                        child: Center(
                                          child: IconButton(
                                            icon: Icon(Icons.upload),
                                            onPressed: (){
                                              _selectImg(context);
                                            },
                                          ),
                                        ),
                                      ),
                                    ]
                                ),
                                if(_listFile!= null)
                                  ... [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: ()
                                        {
                                          _selectImg(context);
                                        },
                                        child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: _listFile.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      width: 80.w,
                                                      height: 40.h,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              image: MemoryImage(_listFile[index]),
                                                              fit: BoxFit.cover
                                                          )
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: 0,
                                                      top: 0,
                                                      child: IconButton(
                                                        icon: Icon(Icons.close_outlined),
                                                        color: Colors.white,
                                                        onPressed: (){
                                                          setState(() {
                                                            _listFile.removeAt(index);
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                        ),
                                      ),
                                    ),
                                  ]


                              ],
                            )

                        );
                      },
                    );
            }
       return Center();
        },

    );
  }
  _selectImg(BuildContext context) async{
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: Text("Đăng tải ảnh"),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20.sp),
            child: Text(("Chụp ảnh")),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await PickImg(ImageSource.camera);
              setState(() {
                _listFile.add(file);
              });
            },
          ),
          SimpleDialogOption(

            padding: EdgeInsets.all(20.sp),
            child: Text(("Chọn hình từ thư viện")),
            onPressed: () async{
              Navigator.of(context).pop();
               ImagePicker imagePicker = ImagePicker();
              List? _file = await imagePicker.pickMultiImage();
              _file?.forEach((element) async{
                file8  = await element.readAsBytes();
                setState(() {
                  _listFile.add(file8!);
                });
              });

            },
          ),
        ],
      );
    },);

  }
}
