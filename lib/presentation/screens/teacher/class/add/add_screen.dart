import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/configs/router.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/screens/login/login_screen.dart';
import 'package:luan_an/presentation/screens/teacher/class/add/screen/addparent/addparent_screen.dart';
import 'package:luan_an/presentation/screens/teacher/class/add/screen/addteacher/addteacher_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class AddScreen extends StatefulWidget {
  final ClassModel classModel;
  const AddScreen({Key? key, required this.classModel,}) : super(key: key);

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen>{
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              titleTextStyle: TextStyle(color: Colors.black),
              title:  ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Text("Kết nối với lớp",  maxLines: 4,style: TextStyle(fontSize: 18.sp,fontWeight: FontWeight.bold),)
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
              bottom: TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      text: "Phụ huynh",
                    ),
                    Tab(
                      text: "Giáo viên",
                    ),
                  ]),
            ),
            resizeToAvoidBottomInset: false,
            body: TabBarView(
              children: [
                AddParentScreen(classModel: widget.classModel),
                AddTeacherScreen(classModel: widget.classModel,)
              ],
            ),

          )),

      debugShowCheckedModeBanner: false,
    );
  }
}
