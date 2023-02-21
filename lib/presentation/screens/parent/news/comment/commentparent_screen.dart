import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:luan_an/data/model/news_model.dart';
import 'package:luan_an/presentation/common_blocs/profile/bloc.dart';
import 'package:luan_an/presentation/screens/parent/news/comment/widget/commentparent_bottom.dart';
import 'package:luan_an/presentation/screens/parent/news/comment/widget/commentparent_form.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../data/repository/user_repository/firebase_user_repo.dart';
import 'bloc/bloc.dart';
class CommentScreenParent extends StatefulWidget {
  final NewsModel newModel;
  const CommentScreenParent({Key? key, required this.newModel}) : super(key: key);

  @override
  State<CommentScreenParent> createState() => _CommentScreenParentState();
}

class _CommentScreenParentState extends State<CommentScreenParent> {
  UserAuthRepository userAuthRepository = new UserAuthRepository();
  String pushToken ="";
  @override
  void initState() {
      userAuthRepository.getUserByID(widget.newModel.idUser).then((value)
      {
        setState(() {
          pushToken = value.pushToken;
        });
      });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
        create: (context) => CommentBloc()..add(CommentLoad(widget.newModel.classId,widget.newModel.id)),),
        BlocProvider(
          create: (context) => ProfileBloc(),)
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
                  child: Text('Bình luận',style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
              actions: [
              ],
            ),
            resizeToAvoidBottomInset: true,
            body: SingleChildScrollView(
              reverse: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommentFormparent(),
                ],
              ),
            ),
            bottomNavigationBar: CommentBottomParent(newModel: widget.newModel,pushToken: pushToken) ,
        ),
    );
  }
}
