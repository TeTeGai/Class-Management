import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/common_blocs/notification/bloc.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ClassNotificationScreen extends StatefulWidget {
  const ClassNotificationScreen({Key? key}) : super(key: key);

  @override
  State<ClassNotificationScreen> createState() => _ClassNotificationScreenState();
}

class _ClassNotificationScreenState extends State<ClassNotificationScreen> {

  @override
  Future<ClassModel> getclassByID(String id) async{
    return await FirebaseFirestore.instance.collection("class")
        .doc(id)
        .get()
        .then((doc) => ClassModel.formMap(doc.data()!));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle: TextStyle(color: Colors.black),
            title:  ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Text('Thông báo',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
            ),
            centerTitle: true,
            leading:   Padding(
              padding: const EdgeInsets.all(8.0),
              child: MaterialButton(
                onPressed: () {
                  Navigator.of(context, rootNavigator: true).pop();
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
          body: BlocBuilder<NotificationBloc,NotificationState>(
            bloc:  NotificationBloc()..add(ClassNotificationLoad()),
            builder: (context, state) {
              if(state is ClassNotificationLoaded)
                {
                  var notificationModel = state.notificationModel;
                  return Container(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                              key: UniqueKey(),
                              shrinkWrap: true,
                              itemCount: notificationModel.length,
                              itemBuilder: (context, index) {
                                return Dismissible(
                                  key: UniqueKey(),
                                  onDismissed: (direction) {
                                    NotificationBloc()..add(ClassNotificationRemove(notificationModel[index].id));
                                  },
                                  background: Container(
                                    padding: const EdgeInsets.all(10),
                                    margin: const EdgeInsets.symmetric(vertical: 12),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.red,
                                    ),
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                      size: 40,
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                  child:    Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: (){
                                          NotificationBloc()..add(ClassNotificationUpdateModel(notificationModel[index].id));
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10), // <= No more error here :)
                                              color: notificationModel[index].isSeen?Colors.white:Colors.grey.shade200,
                                            ),
                                                      child: Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              ClipRRect(
                                                                borderRadius: BorderRadius.all(Radius.circular(50)),
                                                                child: CircleAvatar(
                                                                  radius: 25.sp,
                                                                  backgroundImage: NetworkImage(notificationModel[index].avatar),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Container(
                                                                    child: Column(
                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                      children: [
                                                                        SizedBox(
                                                                          width: 70.w,
                                                                          height: 10.h,
                                                                          child: Column(
                                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                                            children: [
                                                                              Text(
                                                                               notificationModel[index].title ,
                                                                                style:
                                                                                TextStyle(fontSize: 17.sp, ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                softWrap: false,
                                                                              ),
                                                                              Text(
                                                                                DateFormat.MMMd('vi').add_jm().format(notificationModel[index].timeCreate.toDate()),
                                                                                style:
                                                                                TextStyle(fontSize: 14.sp, ),
                                                                                overflow: TextOverflow.ellipsis,
                                                                                maxLines: 2,
                                                                                softWrap: false,
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      )
                                 )
                                ),
                                  ));





                              }
                          ),
                        )

                      ],
                    ),
                  );
                }
              return CircularProgressIndicator();

            },
          )
    );
  }
}
