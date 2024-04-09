import 'package:cloud_firestore/cloud_firestore.dart';

class GetMarker {
  Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> getMarkers() async {
    return await FirebaseFirestore.instance
        .collection('requests')
        .get()
        .then((value) {
      return value.docs;
    });
  }
}
