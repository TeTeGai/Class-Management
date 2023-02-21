import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatsForm extends StatefulWidget {
  const ChatsForm({Key? key}) : super(key: key);

  @override
  State<ChatsForm> createState() => _ChatsFormState();
}

class _ChatsFormState extends State<ChatsForm> with  AutomaticKeepAliveClientMixin<ChatsForm>{
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
        if(state is MessUserLoaded)
          {
            var chatModel = state.chatModel;
            return BlocBuilder<ProfileBloc,ProfileState>(
              builder: (context, state) {
                if(state is LoadedProfile)
                  {
                    return Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Expanded(
                            child: AnimationLimiter(
                              child: ListView.builder(
                                key: UniqueKey(),
                                shrinkWrap: true,
                                itemCount: chatModel.length,
                                itemBuilder: (context, index) {
                                  return AnimationConfiguration.staggeredList(
                                    position: index,
                                    duration: const Duration(milliseconds: 375),
                                    child: SlideAnimation(
                                      verticalOffset: 50.0,
                                      child: FadeInAnimation(
                                        child: InkWell(
                                          onTap: (){
                                            Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.CHATINFO,arguments: [state.loggedUser,chatModel[index]] );
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
                                                              backgroundImage: NetworkImage(chatModel[index].profileUrl),
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
                                                              SizedBox(
                                                                width: 70.w,
                                                                child: Text(
                                                                  chatModel[index].name,
                                                                  style:
                                                                  TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
                                                                  overflow: TextOverflow.clip,
                                                                  maxLines: 1,
                                                                  softWrap: false,
                                                                ),
                                                              ),
                                                              SizedBox(height: 5,),
                                                              SizedBox(
                                                                width: 70.w,
                                                                child: Text(
                                                                  chatModel[index].lastMessage  ,
                                                                  style:
                                                                  TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500,color: Colors.grey),
                                                                  overflow: TextOverflow.clip,
                                                                  maxLines: 1,
                                                                  softWrap: false,
                                                                ),
                                                              ),
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
                                },),
                            ),
                          )
                        ],
                      ),
                    );
                  }
              return Center();
              },

            );
          }
           return Center();
      },
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
