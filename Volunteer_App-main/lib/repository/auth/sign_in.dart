import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class SignIn {

  final _auth = FirebaseAuth.instance;

  Future<String> signIn(
      {required String password,
        required String email,
      }) async {
    String res = 'Error';
    try{

      await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) =>  res = 'success');

      return res;
    }
    on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email');
        res = 'No user found for that email';
      }
      else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user');
        res = 'Wrong password provided for that user';
      }
      else{

        res = e.message.toString();
      }
      debugPrint(e.toString());
      return res;
    }
    catch(error, stack){
      debugPrint(error.toString());
      debugPrint(stack.toString());
      res = error.toString();
      return res;

    }//catch
  } //create Function


}