import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/chat/widget/chats_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../common_blocs/profile/bloc.dart';



class ChatsScreen extends StatefulWidget {
  final ClassModel classModel;
  const ChatsScreen({Key? key, required this.classModel}) : super(key: key);

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => ChatBloc()..add(MessLoadUser()),
        ),
        BlocProvider(create: (context) => ProfileBloc()..add(LoadProfile()),),
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
                  child: Text('Trò chuyện',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
              ),
              centerTitle: true,
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
              actions: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("class").doc(widget.classModel.id).collection("notification").where("isSeen",isEqualTo: false).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    return IconButton(
                        onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.CLASSNOTIFICATION),
                        icon: Stack(
                          children: [
                            Icon(Icons.notifications_none_outlined,size: 22.sp,color: Colors.grey,),
                            if (snapshot.hasData)
                              ...[
                                snapshot.data!.docs.length>0?
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.white
                                        ),
                                        borderRadius: BorderRadius.circular(100.0),
                                        color: Colors.red,
                                      ),
                                      child: Text(snapshot.data!.docs.length.toString(),style: TextStyle(fontSize: 14.sp,color: Colors.white),),
                                    )
                                ):   Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 1,
                                            color: Colors.white
                                        ),
                                        borderRadius: BorderRadius.circular(100.0),
                                        color: Colors.red,
                                      ),)
                                ),
                              ]


                          ],
                        )
                    );
                  },

                ),
              ],
            ),
            resizeToAvoidBottomInset: false,
            body: ChatsForm(),
             floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.cyan,
            onPressed: () {
              Navigator.of(context,rootNavigator: true).pushNamed(AppRouter.CHATADD);
            },
            child: Icon(Icons.add,size: 25.sp,),
          ),
        ),
    );
  }
}
