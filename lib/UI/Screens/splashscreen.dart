import 'package:flutter/material.dart';
import 'package:todo/UI/Screens/Home.dart';
import 'package:todo/UI/Screens/login-screen.dart';
import 'package:todo/utilties/AppStyle.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "splash";

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2),
        () => Navigator.pushReplacementNamed(context, LoginScreen.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage(AppStyle.Splashlight),
        fit: BoxFit.cover,
      )),
    );
  }
}
