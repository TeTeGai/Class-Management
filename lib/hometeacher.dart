
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/data/model/class_model.dart';
import 'package:luan_an/presentation/screens/teacher/chat/chats_screen.dart';
import 'package:luan_an/presentation/screens/teacher/class/class_screen.dart';
import 'package:luan_an/presentation/screens/teacher/news/news_screen.dart';
import 'package:luan_an/presentation/screens/teacher/schedule/schedule_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


class HomeTeacher extends StatelessWidget {
  final ClassModel classModel;
  const HomeTeacher({Key? key,required this.classModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeTeacher(className1: this.classModel),
    );
  }
}

class homeTeacher extends StatefulWidget {
  final ClassModel className1;
  const homeTeacher({Key? key,required this.className1}) : super(key: key);

  @override
  _homeTeacherState createState() => _homeTeacherState();
}

class _homeTeacherState extends State<homeTeacher> {
  ClassModel get clas =>widget.className1;
  bool isBottomBarVisible = true;
  late PageController _pageController ;
  late List<Widget> _chil;
  int _currentIndex = 0;
  @override
  void initState() {
     _chil = [
      ClassScreen(classModel: clas),
      NewsScreen(classModel: clas),
      ScheduleScreen(classId: clas.id),
      ChatsScreen(classModel: clas),
    ];
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  // @override
  // void dispose() {
  //  _pageController.dispose();
  // }

  void ontapBotbar(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
  void onTabTapped(int index) {
    this._pageController!.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: PageView(
          children:  _chil,
          onPageChanged: ontapBotbar,
          controller: _pageController,
        )


        ,
        // bottomNavigationBar:  isBottomBarVisible ? new BottomNavigationBar(
        //   type: BottomNavigationBarType.fixed,
        //   selectedItemColor: Colors.blue,
        //   unselectedItemColor: Colors.grey,
        //   onTap: onTabTapped,
        //   currentIndex: _currentIndex,
        //   items: [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home),
        //       label: "Lớp học",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.book),
        //       label: "Bảng tin",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.book),
        //       label: "Lớp học",
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.computer),
        //       label: "Trò chuyện",
        //     ),
        //   ],
        // ):Container());
      bottomNavigationBar: BottomBar(
        selectedIndex: _currentIndex,
        onTap: (int index) {
          _pageController.jumpToPage(index);
          setState(() => _currentIndex = index);
        },
        items: <BottomBarItem>[
          BottomBarItem(
            icon: Icon(Icons.home,size: 20.sp,),
            title: Text("Lớp học",style: TextStyle(fontSize: 18.sp),),
            activeColor: Colors.blue,
          ),
          BottomBarItem(
            icon: Icon(Icons.newspaper_rounded,size: 20.sp,),
            title: Text("Bảng tin",style: TextStyle(fontSize: 18.sp),),
            activeColor: Colors.red,
          ),
          BottomBarItem(
            icon: Icon(Icons.calendar_today,size: 20.sp,),
            title: Text("Lịch",style: TextStyle(fontSize: 18.sp),),
            activeColor: Colors.cyan,
          ),
          BottomBarItem(
            icon: Icon(Icons.chat,size: 20.sp,),
            title: Text("Trò chuyện",style: TextStyle(fontSize: 18.sp),),
            activeColor: Colors.orange,
          ),
        ],
      ),
    );
  }

}
