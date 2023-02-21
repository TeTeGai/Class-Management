import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../configs/timestamp.dart';
import '../bloc/bloc.dart';

class CommentForm extends StatefulWidget {
  const CommentForm({Key? key}) : super(key: key);

  @override
  State<CommentForm> createState() => _CommentFormState();
}

class _CommentFormState extends State<CommentForm> {
  late CommentBloc cmtBloc;
  @override
  void initState() {
    cmtBloc = BlocProvider.of<CommentBloc>(context);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return BlocBuilder <CommentBloc,CommentState>(
      builder: (context, state) {
        if(state is CommentLoading)
          {
            return Center(child: CircularProgressIndicator());
          }
        if(state is CommentLoaded)
        {
          var cmtModel = state.cmtModel;
          return cmtModel.length>0 ? ListView.builder(
              key: UniqueKey(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: cmtModel.length,
              itemBuilder: (context, index) {
                return   Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 22.sp,
                                backgroundImage: NetworkImage(cmtModel[index].profilePic),
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(cmtModel[index].name,style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                          Text(cmtModel[index].comment,style: TextStyle(fontSize: 16.sp,)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 4.0),
                                    child: Text(   StringExtension.displayTimeAgoFromTimestamp(cmtModel[index].timeCmt.toDate().toString()),
                                        style: TextStyle(fontSize: 14.sp,)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      )
                  ]
                )
                );
              }
          ):Center();

        }
        return Center();
      },
    );
  }
}
