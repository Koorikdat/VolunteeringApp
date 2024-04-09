import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocode/geocode.dart';
import 'package:geolocator/geolocator.dart';

class SignUp {

  final _auth = FirebaseAuth.instance;

  final _fireStore = FirebaseFirestore.instance.collection('users');

  String _currentLocation = '';
   double _lat = 0.0;
  double _lng = 0.0;

  List months = ['Jan', 'Feb', 'Mar', 'Apr', 'May','Jun','Jul','Aug','Sep','Oct','Nov','Dec'];

  Future<String> signUp(
      { required String email,
        required String password,
        required String name,
      }) async {
    String res = 'success';

    String isLocationGiven = await _getCurrentLocation();

    if(isLocationGiven == 'success') {
      try {

        final credential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        User user = credential.user!;

        await user.updateDisplayName(name);

        _fireStore.doc(_auth.currentUser!.uid).collection('userRequests');

        await _fireStore.doc(_auth.currentUser!.uid).set({
          'volunteeringSince': '${months[DateTime
              .now()
              .month - 1]} ${DateTime
              .now()
              .year}',
          'location': _currentLocation,
          'lat': _lat,
          'lng': _lng,
        });




        // final u7 = const Uuid().v4();
        // await FirebaseFirestore.instance.collection('requests').doc(u7).set({
        //   'address1' : '241 Riverview Bivd',
        //   'address2' : 'St Catharines, ON L2T 3M8',
        //   'time' : '10:00 AM',
        //   'lat' : 30.1575,
        //   'lng' : 71.5249,
        //   'id' : u7,
        // });

        return res;

      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          debugPrint('The password provided is too weak.');
          res = 'The password provided is too weak.';
        } else if (e.code == 'email-already-in-use') {
          debugPrint('The account already exists for that email.');
          res = 'The account already exists for that email.';
        }
        return res;
      } catch (e) {
        debugPrint(e.toString());
        res = e.toString();
        return res;
      }
    }
    return isLocationGiven;
  } //sign up Function

  // Current location
  Future<String> _getCurrentLocation() async {
    Position? position;
    String  isLocationEnabled = await _handleLocationPermission();
    if(isLocationEnabled == 'success') {
      try {
        position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high,
            forceAndroidLocationManager: true,
            timeLimit: const Duration(seconds: 30));
          final currentAddress = await GeoCode().reverseGeocoding(
              latitude: position.latitude,
              longitude: position.longitude);
          _currentLocation ='${currentAddress.city.toString()}, ${currentAddress.countryCode.toString()}';
          _lat = position.latitude;
          _lng = position.longitude;
          debugPrint('//////////// address ${currentAddress.toString()}');
          return 'success';
      } catch (e) {
        position = null;
        debugPrint('//////////////// error ${e.toString()}');
        return e.toString();
      }
    }
    return isLocationEnabled;
  } //location


 // Location permission
  Future<String> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint('Location services are disabled. Please enable the services');
      return 'Location services are disabled. Please enable the services';
    }
    await Geolocator.requestPermission();
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint('Location permissions are denied');
        return 'Location permissions are denied';
      }
    }
    if (permission == LocationPermission.deniedForever) {
     debugPrint('Location permissions are permanently denied, we cannot request permissions.');
      return 'Location permissions are permanently denied, we cannot request permissions.';
    }
    return 'success';
  }

}

