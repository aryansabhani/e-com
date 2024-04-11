import 'package:e_com/firebase_options.dart';
import 'package:e_com/helper/datahelper.dart';
import 'package:e_com/screen/detail_page.dart';
import 'package:e_com/screen/home_screen.dart';
import 'package:e_com/screen/login.dart';
import 'package:e_com/screen/order_done.dart';
import 'package:e_com/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
await DataHelper.dataHelper.init();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.

  final ThemeData lightTheme = ThemeData(
    // Define light theme colors
    brightness: Brightness.light,
    appBarTheme: AppBarTheme(color: Color(0xFF393185),)
    // backgroundColor:
    // Add more light theme configurations as needed
  );

  final ThemeData darkTheme = ThemeData(
    // Define dark theme colors
    brightness: Brightness.dark,
    // Add more dark theme configurations as needed
  );
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // title: 'Flutter Demo',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      // home: HomePage(),
      getPages: [
        GetPage(name: '/', page: () => AnimatedSplas(),),
        GetPage(name: '/login', page: () => Login_Page(),),
        GetPage(name: '/detail', page: () => DetailPage(),),
        GetPage(name: '/orderDone', page: () => OrderDone(),),
        GetPage(name: '/home', page: () => HomePage(),),
      ],
    );
  }
}
