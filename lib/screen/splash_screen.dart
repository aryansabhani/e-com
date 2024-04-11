// import 'dart:async';
// import 'dart:developer';
//

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:e_com/screen/home_screen.dart';
import 'package:e_com/screen/login.dart';
import 'package:flutter/material.dart';
// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:http/http.dart' as http;

class AnimatedSplas extends StatefulWidget {
  const AnimatedSplas({super.key});

  @override
  State<AnimatedSplas> createState() => _AnimatedSplasState();
}

class _AnimatedSplasState extends State<AnimatedSplas> {
  // inquriry_controller controller = Get.put(inquriry_controller());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // controller.getuserdata();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  // bool cango = false;
  Widget build(BuildContext context) {
    Size s = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedSplashScreen(
        splashIconSize: s.height * 0.2,
        splash: Image.asset("asstes/image/ss.jpeg", fit: BoxFit.fill,
        ),
        nextScreen:   HomePage(),
      ),
      backgroundColor: Colors.black,
    );
  }
}