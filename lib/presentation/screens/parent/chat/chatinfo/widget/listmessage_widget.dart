import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/chat_model.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import 'package:intl/intl.dart';

import 'mymessage_widget.dart';
import 'othermessage_widget.dart';
class ListMessageWidget extends StatefulWidget {
  final ChatModel otherModel;
  const ListMessageWidget({Key? key, required this.otherModel}) : super(key: key);

  @override
  State<ListMessageWidget> createState() => _ListMessageWidgetState();
}

class _ListMessageWidgetState extends State<ListMessageWidget> {
  late ChatBloc chatBloc;
  final ScrollController messageController = ScrollController();
  @override
  void initState() {
    chatBloc = BlocProvider.of<ChatBloc>(context)..add(TextLoad(widget.otherModel.contactId));
    super.initState();
  }
  @override
  void dispose() {
    messageController.dispose();
    chatBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc,ChatState>(
      builder: (context, state) {
        if(state is TextLoaded)
          {
            var textModel = state.textModel;
            SchedulerBinding.instance.addPostFrameCallback((_) {
              messageController
                  .jumpTo(messageController.position.maxScrollExtent);
            });
            return  ListView.builder(
              shrinkWrap: true,
              controller: messageController,
              itemCount: textModel.length,
              itemBuilder: (context, index) {
                if(textModel[index].senderId == FirebaseAuth.instance.currentUser!.uid)
                  {
                //       return GroupedListView<dynamic,DateTime>(
                //           elements: textModel.toList(),
                //           groupBy: (element) =>  element.time.toDate(),
                //         groupSeparatorBuilder: ( element){
                //           String date = DateFormat('dd. MMMM, EEEE').format(element);
                //          return Container(
                //             width: double.infinity,
                //             padding: const EdgeInsets.all(16),
                //             color: Colors.white,
                //             child: Text(date),
                //           );},
                //         itemBuilder: (context, element) {
                // return Padding(
                // padding: const EdgeInsets.all(8.0),
                // child: MyMessageCard(
                // message: textModel[index].text,
                // date:DateFormat.yMd().add_jm().format(textModel[index].time.toDate()),
                // username: textModel[index].senderId,
                // isSeen:textModel[index].isSeen,
                // type: textModel[index].type));
                //         },
                //       );
                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MyMessageCard(
                              message: textModel[index].text,
                              date:DateFormat.Hm().format(textModel[index].time.toDate()),
                              username: textModel[index].senderId,
                              isSeen:textModel[index].isSeen,
                              type: textModel[index].type));
                  }
                return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: OhterMessageCard(
                        message: textModel[index].text,
                        date:DateFormat.Hm().format(textModel[index].time.toDate()),
                        username: textModel[index].senderId,
                        isSeen:textModel[index].isSeen,
                        type: textModel[index].type));
              },
            );
          }
       return Center();
      },

    );
  }
}
