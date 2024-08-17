import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/UI/Screens/Home.dart';
import 'package:todo/UI/Screens/register-screen.dart';
import 'package:todo/utilties/dialogs.dart';
import 'package:todo/utilties/usermodel.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "login";

  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Welcome back !",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
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
                obscureText: true,
                decoration: const InputDecoration(
                  label: Text(
                    "Password",
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
              ElevatedButton(
                  onPressed: () {
                    //ShowLoading(context);
                   signin();
                  },
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    child: Row(
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(fontSize: 18),
                        ),
                        Spacer(),
                        Icon(Icons.arrow_forward)
                      ],
                    ),
                  )),
              const SizedBox(
                height: 18,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, RegisterScreen.routeName);
                },
                child: const Text(
                  "Create account",
                  style: TextStyle(fontSize: 18, color: Colors.black45),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void signin() async {
    String message;
    try {
      ShowLoading(context);
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      UserDM.currentUser=await GetDataFromFireStore(credential.user!.uid);

    if(context.mounted) {
      HideLoading(context);
      Navigator.pushReplacementNamed(context, Home.routeName);
    }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credentials') {
        message='Wrong password or email provided for that user.';
      } else  {
        message='something went wrong try again later.';
      }if(context.mounted){
        HideLoading(context);
        ShowErrorDialog(context,title: message);
      }

    }
    }

  Future<UserDM> GetDataFromFireStore(String id) async{
    CollectionReference ref=FirebaseFirestore.instance.collection(UserDM.CollectionName);
    DocumentReference documentReference=ref.doc(id);
     DocumentSnapshot snap=await documentReference.get();
     return UserDM.fromJason(snap.data() as Map<String,dynamic>);

  }
}
