import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRequests {

  Stream<QuerySnapshot<Map<String, dynamic>>> userRequests(String status) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('UserRequests')
        .where('status' , isEqualTo: status)
        .snapshots();
  }

} //class
