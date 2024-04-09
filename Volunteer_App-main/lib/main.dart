import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:volunteer_application/AuthScreens/SplashScreen.dart';
import 'package:volunteer_application/AuthScreens/sign_up_screen.dart';
import 'package:volunteer_application/NavBar/NavigationBar.dart';

import 'AppConstants/AppConstants.dart';
import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true, cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED);
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

//comment by ayesha again

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(397, 852),
        splitScreenMode: true,
        builder: (builder, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Volunteer',
            theme: ThemeData(scaffoldBackgroundColor: kColorWhite248),
            home:  const SplashScreen(),
          );
        });
  }
}
