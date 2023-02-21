import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';

class LikesScreen extends StatefulWidget {
  final NewsModel newsModel;
  const LikesScreen({Key? key, required this.newsModel}) : super(key: key);

  @override
  State<LikesScreen> createState() => _LikesScreenState();
}

class _LikesScreenState extends State<LikesScreen> {


  @override
  Widget build(BuildContext context) {
    if(widget.newsModel.likes.length >0)
      {
        return  BlocBuilder(
          bloc: NewsBloc()..add(LikesLoadUser(widget.newsModel.likes)),
          builder: (context, state) {
            if(state is NewsLoading)
            {
              return Center(child: CircularProgressIndicator());
            }
            if(state is ListLikesLoaded)
            {
              var listLikes = state.listLikes;
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.black),
                  titleTextStyle: TextStyle(color: Colors.black),
                  title:  ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400),
                      child: Text('Lượt thích',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
                  ),
                  centerTitle: true,
                  leading: Padding(
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
                body: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(child: Text("Có tất cả "+ widget.newsModel.likes.length.toString() + " người đã yêu thích tin của bạn",style: TextStyle(fontSize: 17.sp),)),


                    listLikes.length>0 ? ListView.builder(
                        key: UniqueKey(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        itemCount: listLikes.length,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              SizedBox(height: 10.h,),
                              SizedBox(width: 3.w,),
                              Stack(
                                  children:[
                                    CircleAvatar(
                                      radius: 25.sp,
                                      backgroundImage: NetworkImage(listLikes[index].avatar),
                                    ),
                                    Positioned(
                                        right: 0,
                                        bottom: 0,
                                        child: Container(
                                            padding: EdgeInsets.all(2.5),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  width: 2,
                                                  color: Colors.grey.shade300
                                              ),
                                              borderRadius: BorderRadius.circular(100.0),
                                              color: Colors.white,
                                            ),
                                            child: Icon( Icons.favorite, color: Colors.red,
                                            )
                                        )
                                    )
                                  ]

                              ),
                              SizedBox(width: 5.w,),
                              SizedBox(
                                child: Text(listLikes[index].firstName + " "+ listLikes[index].lastName,
                                  style: TextStyle(fontSize: 17.sp),),
                                width: 50.w,
                              )
                            ],
                          );
                        }
                    ):Center(),
                  ],
                ),
              );
            }
            return Center();

          },

        );
      }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(color: Colors.black),
        title:  ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Text('Lượt thích',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
        ),
        centerTitle: true,
        leading: Padding(
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Center(child: Text("Chưa có người yêu thích tin của bạn",style: TextStyle(fontSize: 17.sp),)),

        ],
      ),
    );
  }
}
