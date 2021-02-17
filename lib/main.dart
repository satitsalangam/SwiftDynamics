import 'package:flutter/material.dart';
import 'package:swiftdynamics/login/login.dart';

void main() {
  // SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.black, statusBarBrightness: Brightness.light));
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primaryColor: Color(0xFF031477),
        // accentColor: Colors.red
        //backgroundColor: Colors.black,
      ),
      title: 'Swift Dynamics',
      //home: MyUserList(),
      home: LoginScreen(),
    );
  }
}
