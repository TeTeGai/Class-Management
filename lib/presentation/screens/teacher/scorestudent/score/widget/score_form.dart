import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:luan_an/presentation/common_blocs/score/bloc.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/score/editscore/score_addwidget.dart';
import 'package:luan_an/presentation/screens/teacher/scorestudent/score/widget/score_editwidget.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:intl/intl.dart';

import '../../../../../../data/model/student_model.dart';
import '../../../../../../data/repository/user_repository/firebase_user_repo.dart';
import '../../../../../../utils/pushnotifications.dart';
import '../../../../../../utils/snackbar.dart';



class ScoreForm extends StatefulWidget {
  final StudentModel studentModel;
  final String? pushToken;
  const ScoreForm({Key? key, required this.studentModel, this.pushToken,}) : super(key: key);

  @override
  State<ScoreForm> createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> with AutomaticKeepAliveClientMixin<ScoreForm>{
    var cateSelect;
    var  scoreSelect;
    late String nameUser;
    UserAuthRepository userAuthRepository = new UserAuthRepository();
    var currentdate = DateTime.now();
    TextEditingController cmtEditingController = TextEditingController();
    late ScoreBloc scoreBloc;
    @override
  void initState() {
    scoreBloc = BlocProvider.of<ScoreBloc>(context);
    userAuthRepository.getUserByID(FirebaseAuth.instance.currentUser!.uid).then((value) {
      nameUser = value.sex +" "+ value.firstName + " " + value.lastName;
    });
    super.initState();
  }
  @override
  void dispose() {
    scoreBloc.close();
    super.dispose();
  }

    void onPress(title,img)
    {
      var day =DateFormat('dd/MM/yyyy').format(currentdate);
      MySnackBar.error(message: widget.studentModel.name+" được "+ scoreSelect.toString() + " điểm "+cateSelect +" "+ title, color: Colors.cyan, context: context);
      scoreBloc.add(ScoreListAdd(
          title,
          int.parse(scoreSelect.toString()),
          "",
          day,
          widget.studentModel.id,
          nameUser,
          img,
          widget.studentModel.idParent,
          widget.studentModel.name +" được $scoreSelect $cateSelect môn $title" +" được gửi bởi "+nameUser,
          cateSelect ));
      if(widget.pushToken!= "")
      {
        PushNotifications.callOnFcmApiSendPushNotifications(
            body: widget.studentModel.name +" "+  int.parse(scoreSelect.toString()).toString() + " điểm "+title,
            To: widget.pushToken!);
      }

    }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreBloc,ScoreState>(
      buildWhen: (previous, current) => current is ScoreLoaded,
      builder: (context, state) {
        if (state is ScoreLoading)
        {
          return Center(child: CircularProgressIndicator());
        }
        if(state is ScoreLoaded)
        {
          var scoreModel = state.scoreModel;
          return Stack(
            children: [
              scoreModel.length>0 ? AnimationLimiter(
                child: GridView.builder(
                  gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,childAspectRatio: (3 / 2),
                  ),
                  key: UniqueKey(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: scoreModel.length +1,
                  itemBuilder: (context, index) {
                    if (index == 0)
                    {
                      return ScoreEditWidget();
                    }
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 375),
                      columnCount: 2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: Container(
                            child: Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: TextButton(
                                    onPressed: (){
                                      cateSelect = scoreModel[index-1].category.first;
                                      scoreSelect = 0;
                                      print(cateSelect);
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return     Dialog(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15.sp),
                                                ),
                                                elevation: 0,
                                                backgroundColor: Colors.transparent,
                                                child: SingleChildScrollView(
                                                  child: Stack(
                                                    children: <Widget>[
                                                      Container(
                                                        padding: EdgeInsets.only(left: 20.sp,top: 45.sp
                                                            + 20.sp, right: 20.sp,bottom: 20.sp
                                                        ),
                                                        margin: EdgeInsets.only(top: 45.sp),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.rectangle,
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.circular(20.sp),
                                                            boxShadow: [
                                                              BoxShadow(color: Colors.black,offset: Offset(0,10),
                                                                  blurRadius: 10
                                                              ),
                                                            ]
                                                        ),
                                                        child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: <Widget>[
                                                            dropDown(scoreModel[index-1].category),
                                                            dropDownScore(scoreModel[index-1].score),
                                                            Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Align(
                                                                  alignment: Alignment.bottomLeft,
                                                                  child: TextButton(
                                                                      onPressed: (){
                                                                        Navigator.of(context).pop();
                                                                      },
                                                                      child: Text("Quay lại",style: TextStyle(fontSize: 18.sp,color: Colors.cyan),)),
                                                                ),
                                                                Align(
                                                                  alignment: Alignment.bottomRight,
                                                                  child: TextButton(
                                                                      onPressed: (){
                                                                        Navigator.of(context).pop();
                                                                        onPress(scoreModel[index-1].title,scoreModel[index-1].avatar);
                                                                      },
                                                                      child: Text("Xác nhận",style: TextStyle(fontSize: 18.sp,color: Colors.cyan),)),
                                                                ),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      Positioned(
                                                        left: 20.sp,
                                                        right: 20.sp,
                                                        child: CircleAvatar(
                                                          backgroundColor: Colors.transparent,
                                                          radius: 45.sp,
                                                          child: ClipRRect(
                                                              borderRadius: BorderRadius.all(Radius.circular(45.sp,)),
                                                              child: Image.asset(scoreModel[index-1].avatar)
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                            );
                                          },);

                                    },
                                    child:  Container(
                                      width: 45.w,
                                      height: 12.h,
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1,color: Colors.grey),
                                        borderRadius: BorderRadius.all(Radius.circular(15.sp)),
                                      ),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(width: 10,),
                                          CircleAvatar(radius: 25.sp,
                                            backgroundImage: AssetImage(scoreModel[index - 1].avatar),
                                            backgroundColor: Colors.white,
                                          ),
                                          SizedBox(width: 10,),
                                          ConstrainedBox(
                                              constraints: BoxConstraints(maxWidth: 20.w),
                                              child: Text(scoreModel[index - 1].title, maxLines: 2,
                                                  style: TextStyle(fontSize: 15.sp,color: Colors.black),textAlign: TextAlign.center)
                                          ),
                                        ],
                                      ),
                                    )
                                )
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ) :ScoreEditWidget()
            ],
          );
        }
        if(state is ScoreLoadFail) { Text("Sai");}
        return Center(child: Text("Chưa có điểm"));
      },
    );
  }
   Widget dropDown(List item) {
      late List items = item;
      final _formKey = GlobalKey<FormState>();
      return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField2(
                value: cateSelect,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400)
                  ),
                ),
                isExpanded: true,
                hint:  Text(
                  items.first,
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 50,
                buttonWidth: 200,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                items: items
                    .map((item) =>
                    DropdownMenuItem<String>(
                      value: item != null ? item : null,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn giới tính';
                  }
                },
                onChanged: (value) {
                  cateSelect = value.toString();
                  setState(() {
                    cateSelect;
                    print(cateSelect);
                  });

                },
                onSaved: (value) {
                  setState(() {
                    cateSelect = value.toString();
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

    Widget dropDownScore(int numberScore)  {
      late List items =  [for(var i=0; i<=numberScore; i+=1) i];
      final _formKey = GlobalKey<FormState>();
      return Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              DropdownButtonFormField2(
                value: scoreSelect,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400)
                  ),
                ),
                isExpanded: true,
                hint:  Text(
                  items.first.toString(),
                  style: TextStyle(fontSize: 14),
                ),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
                iconSize: 30,
                buttonHeight: 50,
                buttonWidth: 200.h,
                buttonPadding: const EdgeInsets.only(left: 10, right: 10),
                items: items
                    .map((item) =>
                    DropdownMenuItem<int>(
                      value: item != null ? item : null,
                      child: Text(
                        item.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ))
                    .toList(),
                validator: (value) {
                  if (value == null) {
                    return 'Vui lòng chọn giới tính';
                  }
                },
                onChanged: (value) {
                  scoreSelect = value.toString();
                  setState(() {
                    scoreSelect;
                    print(scoreSelect);
                  });

                },
                onSaved: (value) {
                  setState(() {
                    scoreSelect = value.toString();
                  });
                },
              ),
            ],
          ),
        ),
      );
    }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

