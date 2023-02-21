
import 'package:bottom_bar/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:luan_an/presentation/screens/parent/chat/chats_screen.dart';
import 'package:luan_an/presentation/screens/parent/news/news_screen.dart';
import 'package:responsive_sizer/responsive_sizer.dart';




class HomeParent extends StatelessWidget {

  const HomeParent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeParent(),
    );
  }
}

class homeParent extends StatefulWidget {

  const homeParent({Key? key}) : super(key: key);

  @override
  _homeParentState createState() => _homeParentState();
}

class _homeParentState extends State<homeParent> {
  bool isBottomBarVisible = true;
  late PageController _pageController ;
  late List<Widget> _chil;
  int _currentIndex = 0;
  @override
  void initState() {
    _chil = [
      NewsParentScreen(),
      ChatsScreen(),
    ];
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }


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
        bottomNavigationBar:  isBottomBarVisible ? new BottomBar(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          selectedIndex: _currentIndex,
          onTap: (int index) {
            _pageController.jumpToPage(index);
            setState(() => _currentIndex = index);
          },
          items: <BottomBarItem>[
            BottomBarItem(
              icon: Icon(Icons.newspaper_rounded,size: 20.sp,),
              title: Text("Bảng tin",style: TextStyle(fontSize: 18.sp),),
              activeColor: Colors.red,
            ),
            BottomBarItem(
              icon: Icon(Icons.chat,size: 20.sp,),
              title: Text("Trò chuyện",style: TextStyle(fontSize: 18.sp),),
              activeColor: Colors.orange,
            ),
          ],
        ):Container());
  }

}
