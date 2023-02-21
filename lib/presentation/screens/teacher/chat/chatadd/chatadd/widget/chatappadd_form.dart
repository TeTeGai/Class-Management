import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/chat_model.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
class ChatAppAddForm extends StatefulWidget {
  const ChatAppAddForm({Key? key}) : super(key: key);

  @override
  State<ChatAppAddForm> createState() => _ChatAppAddFormState();
}

class _ChatAppAddFormState extends State<ChatAppAddForm> {
  late ChatBloc chatBloc;
  late ProfileBloc profileBloc;

  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context);
    profileBloc= BlocProvider.of<ProfileBloc>(context);
    super.initState();
  }
  @override
  void dispose() {
    chatBloc.close();
    profileBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc,ChatState>(
      builder: (context, state) {
      if(state is UserLoaded)
      {
        var userModel = state.userModel;
        return BlocBuilder<ProfileBloc,ProfileState>(builder: (context, state) {
          if(state is LoadedProfile)
            {
              return userModel.length>0 ? AnimationLimiter(
                child: ListView.builder(
                    key: UniqueKey(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: userModel.length,
                    itemBuilder: (context, index) {
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: InkWell(
                              onTap: (){
                                ChatModel chatModelCurrent;
                                late ChatModel initModel1;
                                setState(() {
                                  chatModelCurrent = ChatModel(
                                    name: userModel[index].firstName+" "+ userModel[index].lastName,
                                    contactId: userModel[index].id,
                                    profileUrl: userModel[index].avatar,
                                    lastMessage: "",
                                    time: Timestamp.now(),
                                  );
                                  initModel1 = chatModelCurrent.cloneWith();
                                });
                                ChatModel chatModelOther;
                                late ChatModel initModel2;
                                setState(() {
                                  chatModelOther = ChatModel(
                                    name: state.loggedUser.firstName +" "+ state.loggedUser.lastName,
                                    contactId: state.loggedUser.id,
                                    lastMessage: "",
                                    profileUrl: state.loggedUser.avatar,
                                    time: Timestamp.now(),
                                  );
                                  initModel2 = chatModelOther.cloneWith();
                                });
                                chatBloc.add(ChatAdd(initModel1, initModel2, userModel[index].id,false));
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                padding: EdgeInsets.only(top: 10,right: 10,left: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 55,
                                              height: 55,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.all(Radius.circular(50))),
                                              child: ClipRRect(
                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(userModel[index].avatar),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    userModel[index].firstName +" "+userModel[index].lastName,
                                                    style:
                                                    TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                                                  ),
                                                  SizedBox(height: 5,),
                                                  if(userModel[index].role =="teacher")
                                                    ...[
                                                      Text(
                                                        "Giáo viên",
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ]
                                                  else if(userModel[index].role =="parent")
                                                    ...[
                                                      Text(
                                                        "Phụ huynh",
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ]
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 60,right: 10),
                                      child: Divider(thickness: 1.50,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                ),
              ):Center();
            }
          return Center();
        },);

      }
      return Center();
    },);
  }
}
