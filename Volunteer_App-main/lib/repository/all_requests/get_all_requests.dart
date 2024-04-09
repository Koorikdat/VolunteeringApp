import 'package:cloud_firestore/cloud_firestore.dart';

class GetAllRequests {

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllRequests() {
    return FirebaseFirestore.instance
        .collection('requests')
        .snapshots();
  }

} //class
