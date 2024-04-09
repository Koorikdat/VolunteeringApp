import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';
import 'package:volunteer_application/repository/models/all_requests_model.dart';
import 'package:volunteer_application/repository/models/user_requests_model.dart';

class OnAcceptRequest {

  Future<bool> onAcceptRequest(AllRequestsModel model) async {
    try{
      //Delete from all requests
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(model.id)
          .delete();

      //Add in user requests
      final id = const Uuid().v4();

      final UserRequestsModel userModel = UserRequestsModel(
          address2: model.address2,
          time: model.time,
          id: id,
          status: 'InProgress',
          address1: model.address1,
          lat: model.lat,
          lng: model.lng);

      await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('UserRequests')
          .doc(id)
          .set(userModel.toMap());


      return true;
    }
    catch (error){
      debugPrint('error: ${error.toString()}');
      return false;
    }
  }

} //class
