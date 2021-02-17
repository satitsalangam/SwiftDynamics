import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:swiftdynamics/model/usermodel.dart';
import 'package:swiftdynamics/register/Register.dart';
import 'package:swiftdynamics/sidebar/sidebar_layout.dart';
import 'package:swiftdynamics/ulility/my_constants.dart';
import 'package:swiftdynamics/ulility/normal_dialog.dart';
import 'package:swiftdynamics/ulility/text_style.dart';

class LoginCredentials extends StatefulWidget {
  @override
  _LoginCredentialsState createState() => _LoginCredentialsState();
}

class _LoginCredentialsState extends State<LoginCredentials> {
  bool loadProcess = true;
  bool loadStatus = true;
  double screenHeight;
  String username, password;
  UserModel userModel;

  @override
  void initState() {
    super.initState();
    usercheckLogin();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  }

  Future<void> usercheckLogin() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String state = preferences.getString('state');
      print('state>>$state');
      if (state == 'yes') {
        routoService(
          SideBarLayoutAssets(),
        );
      }
    } catch (e) {}
  }

  Future<void> usercheckAuthen() async {
    print(username);
    print(password);
    String url =
        '${MyConstant().domain}Login.php?select=true&userName=$username&passWords=$password';
    try {
      Response response = await Dio().get(url);
      print('res = $response');
      var result = json.decode(response.data);
      print('result>>>>>>>>$result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        String userState = userModel.userState;
        if (userState == 'yes') {
          // normalDialog(context, 'สามารถใช้งานได้');
          routeToService(SideBarLayoutAssets(), userModel);
        } else if (userState == 'no') {
          normalDialog(
              context, 'ถูกยกเลิกสิทธ์การเข้าใช้งานกรุณาติดต่อผู้ดูแลระบบ');
        } else {}
      }
    } catch (e) {
      normalDialog(context, 'ไม่มีข้อมูลผู้ใช้งานหรือรหัสผ่านไม่ถูกต้อง');
    }
  }

  void routoService(Widget myWidget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => myWidget));
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Future<void> routeToService(Widget myWidget, UserModel userModels) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('id', userModels.id);
    preferences.setString('fullname', userModels.name);
    preferences.setString('img', userModels.avatar);
    preferences.setString('email', userModels.email);
    preferences.setString('state', userModels.userState);
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => myWidget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Please Log In', style: bl24TextStyle),
          SizedBox(
            height: size.height * 0.03,
          ),
          Material(
            elevation: 10.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              style: bl24TextStyle,
              onChanged: (value) => username = value.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0 * 0.75, horizontal: 20.0),
                fillColor: Colors.white,
                hintText: 'Username',
                hintStyle: bl18TextStyle,
                suffixIcon: Icon(
                  Icons.person_add_sharp,
                  size: 25.0,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          Material(
            elevation: 10.0,
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            child: TextField(
              obscureText: true,
              style: bl24TextStyle,
              onChanged: (value) => password = value.trim(),
              decoration: InputDecoration(
                border: OutlineInputBorder(borderSide: BorderSide.none),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 20.0 * 0.75, horizontal: 20.0),
                fillColor: Colors.white,
                hintText: 'Password',
                hintStyle: bl18TextStyle,
                suffixIcon: Icon(
                  Icons.lock_outline,
                  size: 25.0,
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          SizedBox(
            height: size.height * 0.04,
          ),
          InkWell(
            onTap: () {
              setState(() {
                if (username == null ||
                    username.isEmpty ||
                    password == null ||
                    password.isEmpty) {
                  normalDialog(context, 'กรุณากรอกข้อมูลให้ครบถ้วน');
                } else {
                  usercheckAuthen();
                }
              });
            },
            child: Material(
              elevation: 10.0,
              shadowColor: Color(0xFF4FC3F7),
              color: Color(0xFF031477),
              borderRadius: BorderRadius.circular(30.0),
              child: Container(
                width: size.width,
                height: size.width * 0.15,
                child: Center(
                  child: Text('Log In', style: wl24TextStyle),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have an account ?",
                style: nameStyle,
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyRegister(),
                    ),
                  );
                },
                child: Text(
                  "Sing Up",
                  style: or16TextStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
