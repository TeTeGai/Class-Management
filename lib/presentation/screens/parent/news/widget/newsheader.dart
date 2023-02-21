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

class NewsParentHeader extends StatefulWidget {
  const NewsParentHeader({Key? key}) : super(key: key);

  @override
  State<NewsParentHeader> createState() => _NewsParentHeaderState();
}

class _NewsParentHeaderState extends State<NewsParentHeader> {
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
                return Padding(
                  padding: const EdgeInsets.only(left: 5.0,top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           GestureDetector(
                              onTap: (){
                                _showBottomSheet();
                              },
                              child: CircleAvatar(
                                radius: 20.sp,
                                backgroundImage: NetworkImage(state.loggedUser.avatar),
                              ),
                            ),
                        ],
                      ),

                    ],
                  ),
                );
              }
            if(state is LoadingProfile)
              {
                return Center(child: Text("1"));
              }
            if(state is LoadFailProfile)
            {
              return Center(child: Text("2"));
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
                          Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.CHANGEPASSWORD);
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
