import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:backyard_delivery/screens/delivery_screen/delivery_screen.dart';
import 'package:backyard_delivery/screens/notifications_screen/notifications_screen.dart';
import 'package:backyard_delivery/screens/settings_screen/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;
  late CurvedAnimation curve;
  PageController _pageController = PageController();
  int currentTab = 0;

  final iconList = <IconData>[
    FontAwesomeIcons.bell,
    FontAwesomeIcons.folder,
    FontAwesomeIcons.cog,
  ];

  List<Widget> _screens = [
    NotificationsScreen(),
    DeliveryScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    final systemTheme = SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(systemTheme);

    _animationController = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    curve = CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.fastOutSlowIn,
      ),
    );
    animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(curve);

    Future.delayed(
      Duration(seconds: 1),
      () => _animationController.forward(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        exit(0);
      },
      child: Scaffold(
        // extendBody: true,
        body: PageView(
          controller: _pageController,
          children: _screens,
          onPageChanged: (index) {
            setState(() {
              currentTab = index;
            });
          },
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar.builder(
          height: MediaQuery.of(context).size.height * 0.1,
          itemCount: iconList.length,
          elevation: 2,
          splashRadius: 5,
          tabBuilder: (int index, bool isActive) {
            final color = isActive ? Colors.black : Color(0xffB09B87);
            return Icon(
              iconList[index],
              size: 22,
              color: color,
            );
          },
          backgroundColor: Color(0xff80392C),
          activeIndex: currentTab,
          splashColor: Colors.brown,
          notchAndCornersAnimation: animation,
          splashSpeedInMilliseconds: 300,
          notchSmoothness: NotchSmoothness.defaultEdge,
          gapLocation: GapLocation.none,
          leftCornerRadius: 24,
          rightCornerRadius: 24,
          onTap: (index) => setState(() => this._onItemTapped(index)),
        ),
      ),
    );
  }
}
