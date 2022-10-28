import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz_app/quiz/controller/quiz_controller.dart';
import 'package:quiz_app/quiz/view/result_screen.dart';
import 'package:quiz_app/quiz/view/widgets/quiz.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final quizController = Get.put(QuizController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{
     await quizController.getAllQuestion();
    });


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Obx(()=>Padding(
        padding: const EdgeInsets.all(30.0),
        child:(quizController.questionIndex < quizController.questions.length)||!quizController.questionLoaded.value
            ? quizController.questions.isNotEmpty?Quiz(
          answerQuestion: quizController.answerQuestion,
          questionIndex: quizController.questionIndex.value,
          questions: quizController.questions,
        ) :SizedBox()//Quiz
            : Result(quizController.totalScore.value, ()=>quizController.resetQuiz),
      ))
    );
  }
}
