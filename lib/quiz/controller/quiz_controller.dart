import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../view/widgets/answer.dart';

class QuizController extends GetxController{
  RxList<Answer> answerList = List<Answer>.empty(growable: true).obs;
  RxBool questionLoaded = false.obs;
 List<Map<String,Object>> questions = [
  ];

  RxInt questionIndex = 0.obs;
  RxInt totalScore = 0.obs;
  Future<void> getAllQuestion()async{
   var fire = FirebaseFirestore.instance;
    QuerySnapshot res=await fire.collection('question').get();
    for(DocumentSnapshot i in res.docs){
      questions.add({
        'questionText':i.get('questionText'),
        'answers':i.get('answer'),

      });
    }
    questionLoaded.value=true;
  }
  void resetQuiz() {
      questionIndex.value = 0;
      totalScore.value = 0;
  }

  void answerQuestion(int score)async {
    print("SCORE $score");
    totalScore.value += score;
      questionIndex.value = questionIndex.value + 1;
    if (questionIndex < questions.length) {
      print('We have more questions!');
    } else {
      var fire = FirebaseFirestore.instance;
      DocumentSnapshot res = await fire.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();
      if(totalScore.value>res.get('highestScore')){
        fire.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
            {
              'name':FirebaseAuth.instance.currentUser!.displayName,
              'highestScore':totalScore.value
            });
      }
      // ignore: avoid_print
      print('No more questions!');
    }
  }
}