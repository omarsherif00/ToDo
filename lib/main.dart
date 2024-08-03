import 'package:flutter/material.dart';
import 'package:todo/UI/Screens/Home.dart';
import 'package:todo/utilties/AppTheme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return MaterialApp(
    debugShowCheckedModeBanner: false
      ,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routes: {
        Home.routeName:(_)=>Home(),

      },
initialRoute: Home.routeName,


    );
  }
}


