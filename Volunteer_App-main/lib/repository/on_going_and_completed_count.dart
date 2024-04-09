import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_application/repository/models/user_requests_model.dart';

class OngoingAndCompletedCount {

  Stream<Map<String, int>> getCount() {
    Map<String, int> map= {};
    int completed = 0;
    int onGoing = 0;
    return FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('UserRequests')
        .snapshots()
        .asyncMap((value) {
          for(final data in value.docs){
           final model = UserRequestsModel.fromMap(data.data());
           print('//////////////////////// ststus ${model.status}');
           if(model.status == 'completed'){
             completed++;
             print('//////////////////////// completed $completed');
           }
           else{
             onGoing++;
             print('//////////////////////// ststus $onGoing');
           }
          }
          map = {
            'onGoing': onGoing,
            'completed': completed,
          };

      return map;
    });
  }
}