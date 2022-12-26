import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/globalvariable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() => _currentIndex = index);
            },
            children: homeScreenItems),
      ),
      bottomNavigationBar: BottomNavyBar(
        itemCornerRadius: 10,
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(title: Text('Home'), icon: Icon(Icons.home)),
          BottomNavyBarItem(title: Text('Appontment'), icon: Icon(Icons.apps)),
          BottomNavyBarItem(
              title: Text('Chat'), icon: Icon(Icons.message_sharp)),
          BottomNavyBarItem(title: Text('Profile'), icon: Icon(Icons.person)),
        ],
      ),
    );
  }
}
    // return Scaffold(
  
    //   bottomNavigationBar: BottomNavyBar(
    //     onTap: navigationTapped,
    //     items: [
    //       // backgroundColor: primaryColor,

    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 0 ? 'asset/homered.png' : "asset/home.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 1 ? 'asset/gridred.png' : "asset/grid.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 2 ? 'asset/chatred.png' : "asset/chat.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //       BottomNavyBarItem(
    //         icon: Image.asset(
    //           _page == 3 ? 'asset/profile.png' : "asset/profile.png",
    //           width: 50,
    //           height: 30,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
 