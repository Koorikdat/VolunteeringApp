import 'package:firebase_auth/firebase_auth.dart';

class EditName {

  Future<bool> editName(String name) async {
    return await FirebaseAuth.instance.currentUser!
        .updateDisplayName(name)
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }
} //class
