import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz_app/login/controller/login_controller.dart';
import 'package:quiz_app/main.dart';
import 'package:quiz_app/quiz/view/quiz_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginController = Get.put(LoginController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if(FirebaseAuth.instance.currentUser!=null){
        Get.to(const MyHomePage());
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            stops: [0.1, 0.5, 0.7, 0.9],
            colors: [
              Colors.indigo.shade800,
              Colors.indigo.shade600,
              Colors.indigo.shade400,
              Colors.indigo.shade200,
            ],
          ),
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "THE QUIZ",
              style: TextStyle(color: Colors.white, fontSize: 55),
            ),
            const Text(
              "Game",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(
              height: 50,
            ),
            InkWell(
              onTap: () async{
                await loginController.signInWithGoogle();
                if(FirebaseAuth.instance.currentUser!=null){
                  Get.to(const MyHomePage());
                }
              },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey)),
                child:loginController.loadingIndicator.value?CircularProgressIndicator(): Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Image(
                      image: AssetImage('assets/google.png'),
                      height: 30,
                      width: 30,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Text("Continue with Google")
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
