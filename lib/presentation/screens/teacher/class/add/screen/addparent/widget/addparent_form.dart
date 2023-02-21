
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';
import 'package:luan_an/presentation/common_blocs/student/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../../../data/repository/user_repository/firebase_user_repo.dart';
class AddParentForm extends StatefulWidget {
  const AddParentForm({Key? key}) : super(key: key);

  @override
  State<AddParentForm> createState() => _AddParentFormState();
}

class _AddParentFormState extends State<AddParentForm> {
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StudentBloc()..add(LoadStudentParent()),
      child: BlocBuilder<StudentBloc,StudentState>(
        builder: (context, state) {
          if(state is LoadedStudentParent)
          {
            var studentModel = state.studentModel;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text("Đã kết nối ("+studentModel.length.toString()+")",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),),
                ),
                studentModel.length>0 ? ListView.builder(
                  key: UniqueKey(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: studentModel.length ,
                  itemBuilder: (context, index)  {
                    return Container(
                      child: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: TextButton(
                              onPressed: (){
                              },
                              child:  Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    backgroundImage: NetworkImage(studentModel[index].avatar),
                                                    radius: 23.sp,
                                                  ),
                                                ]
                                            ),
                                            SizedBox(width: 10,),
                                            StreamBuilder(
                                                stream:  FirebaseFirestore.instance.collection("users").where('id',isEqualTo:studentModel[index].idParent ).snapshots(),
                                                builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                                                  if (!streamSnapshot.hasData) return const Center(child: CircularProgressIndicator());
                                                  return   Column(
                                                    children: [
                                                      SizedBox(
                                                        width: 60.w,
                                                        child: ConstrainedBox(
                                                            constraints: BoxConstraints(maxWidth: 400),
                                                            child: Text("P/h em: " + studentModel[index].name,  maxLines: 2,
                                                              style: TextStyle(fontSize: 15.sp,color: Colors.black,fontWeight: FontWeight.w700),)
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          SizedBox(
                                                            width: 60.w,
                                                            child: ConstrainedBox(
                                                                constraints: BoxConstraints(maxWidth: 400),
                                                                child: Row(
                                                                  children: [
                                                                    Text(streamSnapshot.data!.docs[0]['fristName'] +" "+streamSnapshot.data!.docs[0]['lastName']+"  ",  maxLines: 2,
                                                                      style: TextStyle(fontSize: 15.sp,color: Colors.grey.shade500,fontWeight: FontWeight.w700),),
                                                                    Text(streamSnapshot.data!.docs[0]['phoneNumber'],  maxLines: 2,
                                                                      style: TextStyle(fontSize: 15.sp,color: Colors.grey.shade500,fontWeight: FontWeight.w700),)
                                                                  ],
                                                                )
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  );
                                                }
                                            ),
                                          ],
                                        ),
                                      ),

                                      IconButton(onPressed: (){}, icon: Icon(Icons.more_horiz))
                                    ],
                                  ),
                                  // Text(studentModel[index].nameParent),
                                  // Text(studentModel[index].phoneParent)
                                ],
                              )
                          )
                      ),
                    );
                  },
                ):Center()


              ],
            );
          }
          return Center();
        },
      ),
    );
  }
}
