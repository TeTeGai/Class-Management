import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/chat/chatadd/chatadd/widget/chatappadd_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class ChatsAddScreen extends StatefulWidget {
  const ChatsAddScreen({Key? key}) : super(key: key);

  @override
  State<ChatsAddScreen> createState() => _ChatsAddScreenState();
}

class _ChatsAddScreenState extends State<ChatsAddScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => ChatBloc()..add(ChatLoadUser()),
        ),
        BlocProvider(create: (context) => ProfileBloc()..add(LoadProfile()),)
      ],
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            title:  ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Text('Tin nhắn mới',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
          ),
          resizeToAvoidBottomInset: false,
          body: ChatAppAddForm()
      ),
      
    );
  }
}
