

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news/constants.dart';
import 'package:news/controllers/MenuController1.dart';
import 'package:news/screens/home/home_screen.dart';
import 'package:news/screens/main/components/header.dart';
import 'package:news/screens/main/components/side_menu.dart';

class MainScreen extends StatelessWidget {
  final MenuController1 _controller = Get.put(MenuController1());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _controller.scaffoldkey,
      drawer: SideMenu(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(),
            Container(
              padding: EdgeInsets.all(kDefaultPadding),
              constraints: BoxConstraints(maxWidth: kMaxWidth),
              child: SafeArea(child: HomeScreen()),
            ),
          ],
        ),
      ),
    );
  }
}
