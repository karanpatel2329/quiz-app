import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController{
  RxBool loadingIndicator = false.obs;
  Future<void> signInWithGoogle() async {
    loadingIndicator.value=true;
    await signOut();
    final GoogleSignInAccount? googleUser =
    await GoogleSignIn().signIn().catchError((error) {
      print(error.toString());
      loadingIndicator.value=false;
    });
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    loadingIndicator.value=false;
    await FirebaseAuth.instance.signInWithCredential(credential);
    var fire = FirebaseFirestore.instance;
    DocumentSnapshot res=await fire.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).get();

    print(res);
    if(!res.exists){
      print("EMPTY");
      fire.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).set(
          {
            'name':FirebaseAuth.instance.currentUser!.displayName,
            'highestScore':0
          });
    }
  }

  Future<void> signOut()async{
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }
}
