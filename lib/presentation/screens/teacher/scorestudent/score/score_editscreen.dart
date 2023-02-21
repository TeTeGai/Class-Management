import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/score_model.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../utils/snackbar.dart';
import '../../../../common_blocs/score/score_bloc.dart';
import '../../../../common_blocs/score/score_event.dart';
import 'editscore/score_editform.dart';
class EditScoreScreen extends StatefulWidget {
  final ScoreModel scoreModel;
  const EditScoreScreen({Key? key, required this.scoreModel}) : super(key: key);

  @override
  State<EditScoreScreen> createState() => _EditScoreScreenState();
}

class _EditScoreScreenState extends State<EditScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreBloc(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black),
          title:  ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Text('Chỉnh sửa điểm môn học',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
          actions: [
            IconButton(onPressed: (){

              showDialog(
                context: context,
                builder: (context) {
                  return     Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                      elevation: 0,
                      backgroundColor: Colors.transparent,
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
                                Text("Bạn có chắc chắn muốn xóa điểm!",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700),),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: TextButton(
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Quay lại",style: TextStyle(fontSize: 18.sp,color: Colors.red),)),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomRight,
                                      child: TextButton(
                                          onPressed: () async {
                                            Navigator.of(context).pop();
                                            Navigator.of(context).pop();
                                            ScoreBloc()..add(ScoreDelete(widget.scoreModel.id));
                                            MySnackBar.error(message: "Xóa điểm thành công", color: Colors.cyan, context: context,);


                                          },
                                          child: Text("Xác nhận",style: TextStyle(fontSize: 18.sp,color: Colors.red),)),
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
                                    child: Image.asset("assets/stop.png")
                                )
                            ),
                          ),
                        ],
                      )
                  );
                },);


            }, icon: Icon(Icons.delete,size: 22.sp,color: Colors.grey,))
          ],
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
            reverse: true,
            child: ScoreEditForm(scoreModel: widget.scoreModel)),
      ),
    );
  }
}
