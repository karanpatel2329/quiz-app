import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/leaderboard/view/leader_board.dart';
import 'package:quiz_app/login/view/login_screen.dart';
import 'package:quiz_app/quiz/view/quiz_screen.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: (){
                Get.to(QuizScreen());
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text(
                  'Play Quiz Now',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: (){
                Get.to(LeaderBoardScreen());
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text(
                  'Leaderboard',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            TextButton(
              onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                await GoogleSignIn().signOut();
                Navigator.pop(context);
                Get.to(LoginScreen());
              },
              child: Container(
                color: Colors.blue,
                padding: const EdgeInsets.all(14),
                child: const Text(
                  'Log out',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
