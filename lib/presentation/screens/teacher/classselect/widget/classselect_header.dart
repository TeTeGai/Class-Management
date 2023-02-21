import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/presentation/common_blocs/auth/bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/profile_bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/profile_state.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../data/repository/img_repository/firebase_img_repo.dart';
import '../../../../../utils/image.dart';
import '../../../../common_blocs/profile/bloc.dart';

class ClassSelectHeader extends StatefulWidget {
  const ClassSelectHeader({Key? key}) : super(key: key);

  @override
  State<ClassSelectHeader> createState() => _ClassSelectHeaderState();
}

class _ClassSelectHeaderState extends State<ClassSelectHeader> {
  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context).add(LoadProfile());
  }
  void onPress(String img)
  {
    BlocProvider.of<AuthBloc>(context).add(UpdateAvatar(img));
  }
  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<ProfileBloc,ProfileState>(
          builder: (context, state) {
            if(state is LoadedProfile)
              {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15,top: 15, right: 5),
                            child: RichText(
                              textAlign: TextAlign.start,
                              maxLines: 4,
                              text: TextSpan(
                                style: TextStyle(color: Colors.black, fontSize: 13.sp),
                                children: [
                                  TextSpan(text: "Xin chào" + "\n",style: TextStyle(fontSize: 20.sp,color: Colors.grey.shade600)),
                                  TextSpan(text: state.loggedUser.sex+" "+state.loggedUser.firstName +" " + state.loggedUser.lastName,style: TextStyle(fontSize: 22.sp,color: Colors.deepPurple.shade900,),),
                                ],
                              ),
                              textScaleFactor: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: (){
                              _showBottomSheet();
                            },
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(state.loggedUser.avatar),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15,top: 5),
                      child: Text("Lớp của tôi",style: TextStyle(fontSize: 20.sp,color: Colors.grey.shade600)),
                    ),

                  ],
                );
              }
            if(state is LoadingProfile)
              {
                return Center();
              }
            if(state is LoadFailProfile)
            {
              return Center();
            }
            else
              {
                return Center(child: Text("Something went wrongs."));
              }

          },
        ),
    );
  }
  Future<dynamic> _showBottomSheet() {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(35.0),
        ),
      ),
      builder: (context) {
        return SingleChildScrollView(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: StatefulBuilder(
            builder: ((context, setModalState) {
              return  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                        Container(
                          width: 90.w,
                            child: TextButton(
                              child: Text(
                                "Đăng xuất" ,style: TextStyle(fontSize: 19.sp),
                              ),
                              onPressed: (){
                                 BlocProvider.of<AuthBloc>(context).add(LoggedOut());
                              },
                            ),
                          ),

                    Container(
                      width: 90.w,
                      child: TextButton(
                        child: Text(
                          "Đổi mật khẩu" ,style: TextStyle(fontSize: 19.sp),
                        ),
                        onPressed: (){
                          Navigator.of(context).pushNamed(AppRouter.CHANGEPASSWORD);
                        },
                      ),
                    ),
                    Container(
                      width: 90.w,
                      child: TextButton(
                        child: Text(
                          "Đổi hình đại diện" ,style: TextStyle(fontSize: 19.sp),
                        ),
                        onPressed: (){
                          _selectImg(context);
                        },
                      ),
                    ),
                  ],
                );
            }),
          ),
        );
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
              Navigator.of(context).pop();
              Uint8List file = await PickImg(ImageSource.camera);
              String img = await FirebaseImgRepository().uploadImageToStorage(file,true);
              onPress(img);
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20.sp),
            child: Text(("Chọn hình từ thư viện")),
            onPressed: () async{
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Uint8List file = await PickImg(ImageSource.gallery);
              String img = await FirebaseImgRepository().uploadImageToStorage(file,true);
              onPress(img);
            },
          ),
        ],
      );
    },);
  }
}
