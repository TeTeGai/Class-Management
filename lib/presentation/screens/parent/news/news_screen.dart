import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/presentation/screens/parent/news/sons/sons_screen.dart';
import 'package:luan_an/presentation/screens/parent/news/widget/newsheader.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'bloc/news_bloc.dart';
import 'bloc/news_event.dart';
import 'widget/newswidget.dart';

class NewsParentScreen extends StatefulWidget {
  const NewsParentScreen({Key? key}) : super(key: key);

  @override
  State<NewsParentScreen> createState() => _NewsParentScreenState();
}

class _NewsParentScreenState extends State<NewsParentScreen> {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NewsBloc()..add(NewsParentLoad()),
      child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
                titleTextStyle: TextStyle(color: Colors.black),
                title:  ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 400),
                    child: Text('Trang chủ',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
                ),
                centerTitle: true,
                leading:  NewsParentHeader(),
                actions: [
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users").doc(FirebaseAuth.instance.currentUser!.uid).collection("notification").where("isSeen",isEqualTo: false).snapshots(),
                    builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {

                     return IconButton(
                          onPressed: () => Navigator.of(context, rootNavigator: true).pushNamed(AppRouter.NOTIFICATION),
                          icon: Stack(
                            children: [
                            Icon(Icons.notifications_none_outlined,size: 24.sp,color: Colors.grey,),
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
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SonsScreen(),
                    Container(
                      color: Colors.grey,
                      width: 100.w,
                      height: 1.h,
                    ),
                    NewsWidget(),
                  ],
                ),
              )

      ),
    );
  }
}
