import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/chat_model.dart';
import 'package:luan_an/data/model/user_model.dart';
import 'package:luan_an/data/repository/repository.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/chat/chatinfo/widget/inputmessage_widget.dart';
import 'package:luan_an/presentation/screens/teacher/chat/chatinfo/widget/listmessage_widget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';



class ChatInfoScreen extends StatefulWidget {
  final UserModel currentModel;
  final ChatModel otherModel;
  const ChatInfoScreen({Key? key, required this.currentModel, required this.otherModel}) : super(key: key);

  @override
  State<ChatInfoScreen> createState() => _ChatInfoScreenState();
}

class _ChatInfoScreenState extends State<ChatInfoScreen> {
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  String pushToken ="";
  @override
  void initState() {
    userAuthRepository.getUserByID(widget.otherModel.contactId).then((value)
        {
          setState(() {
            pushToken = value.pushToken;
          });
      return;
    }) ;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(),

      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
          title:  ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text(widget.otherModel.name,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
          ),
          centerTitle: false,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              onPressed: () {
                Navigator.of(context,rootNavigator: true).pop();
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

        ),
        resizeToAvoidBottomInset: true,
        body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  reverse: true,
                    child: ListMessageWidget(otherModel: widget.otherModel)),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputMessWidget(otherModel: widget.otherModel,currentModel: widget.currentModel,pushToken: pushToken,),
              ),
            ],
          ),
        ),
    );
  }
}
