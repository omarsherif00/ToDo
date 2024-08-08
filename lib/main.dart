import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo/UI/Screens/Home.dart';
import 'package:todo/utilties/AppTheme.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyCQrPEEG3SmlZaIWxjlo-_dzRgLoFdT-pg",
        appId: "1:738488154037:android:26c29eb488dff6ae068bfc",
        messagingSenderId: "todo-220aa",
        projectId: "todo-220aa")
  );
  await FirebaseFirestore.instance.disableNetwork();
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


