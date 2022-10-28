import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:quiz_app/quiz/view/widgets/question.dart';

import '../../controller/quiz_controller.dart';
import 'answer.dart';

class Quiz extends StatefulWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({
    Key? key,
    required this.questions,
    required this.answerQuestion,
    required this.questionIndex,
  }) : super(key: key);
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final quizController = Get.put(QuizController());
  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Question(
          widget.questions[widget.questionIndex]['questionText'].toString(),
        ), //Question
        Obx(()=>Column(
          children: (widget.questions[quizController.questionIndex.value]['answers'] as List<dynamic>)
              .map((answer) {
            print(answer);
            print("ANSWER ${answer['score']}");
            return Answer(
                    () => widget.answerQuestion(answer['score']), answer['text'].toString());
          }).toList(),
        ))

            ],
    );
  }
}

