import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/UI/Screens/login-screen.dart';
import 'package:todo/utilties/dialogs.dart';
import 'package:todo/utilties/usermodel.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "register";

  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String email = "";
  String password = "";
  String username = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              TextFormField(
                onChanged: (text) {
                  username = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "user name",
                  ),
                ),
              ),
              TextFormField(
                onChanged: (text) {
                  email = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Email",
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextFormField(
                onChanged: (text) {
                  password = text;
                },
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .2,
              ),
              ElevatedButton(
                  onPressed: () {
                    signup();

                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Create account",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void signup() async {
    String message;
   try {
     ShowLoading(context);
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      RegisterDatainDatabase(UserDM(name: username, ID: credential.user!.uid, Email: email));
     if(context.mounted){
       HideLoading(context);
       Navigator.pushReplacementNamed(context, LoginScreen.routeName);
     }
     } on FirebaseAuthException catch (e) {
       if (e.code == 'weak-password') {
         message='The password provided is too weak.';
       } else if (e.code == 'email-already-in-use') {
         message='The account already exists for that email.';
       }else{
         message='something went wrong try again later';
       }
       if(context.mounted){
         HideLoading(context);
         ShowErrorDialog(context,ButtounTitle: "ok",title: message);
       }
     } catch (e) {
     if(context.mounted) {
       ShowErrorDialog(context, title: "error",
           Body: 'something went wrong try again later');
     }
   }
  }

  void RegisterDatainDatabase(UserDM user) async {
    CollectionReference ref=FirebaseFirestore.instance.collection(UserDM.CollectionName);
    DocumentReference documentReference=ref.doc(user.ID);
    await documentReference.set(user.toJason());

  }


}