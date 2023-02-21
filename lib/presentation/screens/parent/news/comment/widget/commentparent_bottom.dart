import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/comment_model.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../data/model/news_model.dart';
import '../../../../../../utils/pushnotifications.dart';
import '../bloc/bloc.dart';
class CommentBottomParent extends StatefulWidget {
  final NewsModel newModel;
  final String pushToken;
  const CommentBottomParent({Key? key, required this.newModel, required this.pushToken}) : super(key: key);

  @override
  State<CommentBottomParent> createState() => _CommentBottomParentState();
}

class _CommentBottomParentState extends State<CommentBottomParent> {
  TextEditingController textEditingController = TextEditingController();
  late CommentBloc cmtBloc;
  late ProfileBloc profileBloc;
  @override
  void dispose() {
    // TODO: implement dispose
    cmtBloc.close();
    profileBloc.close();
    super.dispose();
  }
  @override
  void initState() {
    cmtBloc = BlocProvider.of<CommentBloc>(context);
    profileBloc =BlocProvider.of<ProfileBloc>(context)..add(LoadProfile());
    super.initState();
  }
  Future<void> onCmt(String avatar,String name) async {
    CommentModel cmtModel;
    late CommentModel initModel;
    Timestamp timestamp = Timestamp.now();
    setState(() {
      cmtModel = CommentModel(
        id: "",
        timeCmt: timestamp,
        name: name,
        likes: [],
       comment: textEditingController.text,
        profilePic: avatar
      );
      initModel = cmtModel.cloneWith();
    });

    cmtBloc.add(
        CommentAdd(widget.newModel.classId,initModel, textEditingController.text , widget.newModel.id)
    );
    textEditingController.clear();
    if(widget.pushToken!= "")
    {
      if(widget.newModel.idUser != FirebaseAuth.instance.currentUser!.uid)
        {
          PushNotifications.callOnFcmApiSendPushNotifications(
              body:  name + " đã bình luận bài của bạn",
              To: widget.pushToken!);
        }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<ProfileBloc,ProfileState>(
        builder: (context, state) {
          if(state is LoadedProfile)
            {
              return SafeArea(
                child: Container(
                  height: 10.h,
                  margin: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                  padding: EdgeInsets.only(left: 15.sp,right: 8.sp),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 20.sp,
                        backgroundImage: NetworkImage(state.loggedUser.avatar),
                      ),
                      Expanded(child: Padding(
                        padding:  EdgeInsets.only(left: 15.sp,right: 8.sp),
                        child: TextFormField(
                          controller: textEditingController,
                          decoration: InputDecoration(
                              border: InputBorder.none
                          ),
                        ),
                      )),
                      IconButton(onPressed: (){
                        if(textEditingController.text.isNotEmpty)
                          {
                            onCmt(state.loggedUser.avatar,state.loggedUser.firstName+" "+ state.loggedUser.lastName);
                          }

                        }, icon: Icon(Icons.send))
                    ],
                  ),
                ),
              );

            }
          return Center();
        },

    );
  }
}
