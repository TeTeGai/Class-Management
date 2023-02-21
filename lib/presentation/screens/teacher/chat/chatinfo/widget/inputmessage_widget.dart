import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:image_picker/image_picker.dart';
import 'package:luan_an/data/repository/img_repository/firebase_img_repo.dart';
import 'package:luan_an/presentation/common_blocs/chat/bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../../../../data/model/chat_model.dart';
import '../../../../../../data/model/user_model.dart';
import '../../../../../../main.dart';
import '../../../../../../utils/image.dart';
import '../../../../../../utils/pushnotifications.dart';




class InputMessWidget extends StatefulWidget {
  final UserModel currentModel;
  final ChatModel otherModel;
  final String pushToken;
  const InputMessWidget({Key? key, required this.currentModel, required this.otherModel, required this.pushToken}) : super(key: key);

  @override
  State<InputMessWidget> createState() => _InputMessWidgetState();
}

class _InputMessWidgetState extends State<InputMessWidget> {
  TextEditingController textEditingController = new TextEditingController();
  late ChatBloc chatBloc;
  Uint8List? file8 ;

  @override
  void initState() {
    textEditingController.clear();
    chatBloc = BlocProvider.of<ChatBloc>(context);
    super.initState();
  }
  void onPress(String type,String text,String lastText)
  {
    chatBloc.add(TextSent(
        text,
        lastText,
        widget.currentModel.id,
        widget.currentModel.firstName + " " + widget.currentModel.lastName,
        widget.otherModel.contactId,
        widget.otherModel.name,
        type,
        false,
        Timestamp.now(),
        ));
  }

  @override
  void dispose() {
    chatBloc.close();
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: ChatBloc(),
        builder: (context, state) {
          return Column(
            children: [

              _inputMess(),
            ],
          );
        },
      );
  }
  _inputMess()
  {
    return Row(
      children: [
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.sp),
                boxShadow: [
                  BoxShadow(
                    color:  Colors.black.withOpacity(.2),
                    spreadRadius: 1,
                    blurRadius: 1,
                  )
                ]
              ),
              child: Row(
                children: [

                  SizedBox(width: 5.w,),
                  Expanded(
                    child: Scrollbar(
                      child: TextField(
                        controller: textEditingController,
                        decoration: InputDecoration(
                          hintText: "Nhập văn bản",
                        ),
                      ),
                    ),
                  ),
                  IconButton(onPressed: () async {
                    FilePickerResult? result = await FilePicker.platform.pickFiles();

                    if (result != null) {
                      File? file = File(result.files.single.path!);

                      String filelink = await FirebaseImgRepository().uploadFile(file!);
                      onPress("file",filelink,widget.currentModel.lastName + " đã gửi file");
                    } else {
                      // User canceled the picker
                    }



                  }, icon:Icon(Icons.link), ),

                  SizedBox(width: 1 .w,),
                  IconButton(onPressed: () {
                    _selectImg(context);

                  }  , icon: Icon(Icons.camera_alt),),
                  SizedBox(width: 5.w,),
                ],
              ),
            )
        ),
        SizedBox(width: 5.w,),
        IconButton(onPressed: () {
        onPress("text",textEditingController.text,textEditingController.text);
        PushNotifications.callOnFcmApiSendPushNotifications(
            body: widget.currentModel.firstName +
            " " + widget.currentModel.lastName + " đã gửi: "
                +textEditingController.text ,
            To: widget.pushToken);
        textEditingController.clear();
        } , icon:   Icon(Icons.send))

      ],
    );
  }

  _selectImg(BuildContext context) async{
    return showDialog(context: context, builder: (context) {
      return SimpleDialog(
        title: Text("Đăng tải ảnh"),
        children: [
          SimpleDialogOption(
            padding: EdgeInsets.all(20.sp),
            child: Text(("Chụp ảnh")),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await PickImg(ImageSource.camera);
              String img = await FirebaseImgRepository().uploadImageToStorage(file,true);
              onPress("img",img,widget.currentModel.lastName + " đã gửi hình ảnh");
              PushNotifications.callOnFcmApiSendPushNotifications(
                  body: widget.currentModel.firstName +
                      " " + widget.currentModel.lastName + " đã gửi hình ảnh",
                  To: widget.pushToken,url: img);
            },
          ),
          SimpleDialogOption(
            padding: EdgeInsets.all(20.sp),
            child: Text(("Chọn hình từ thư viện")),
            onPressed: () async{
              Navigator.of(context).pop();
              Uint8List file = await PickImg(ImageSource.gallery);
              String img = await FirebaseImgRepository().uploadImageToStorage(file,true);
              onPress("img",img,widget.currentModel.lastName + " đã gửi hình ảnh");
              PushNotifications.callOnFcmApiSendPushNotifications(
                  body: widget.currentModel.firstName +
                      " " + widget.currentModel.lastName + " đã gửi hình ảnh",
                  To: widget.pushToken,url: img);
            },
          ),
        ],
      );
    },);
  }

}
