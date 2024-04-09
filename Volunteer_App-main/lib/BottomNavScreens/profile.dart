import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/BottomNavScreens/profileCustomWidgets.dart';
import 'package:volunteer_application/repository/on_going_and_completed_count.dart';

import '../Screens/EditScreen.dart';
import '../repository/get_volunteering_date.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final User _auth = FirebaseAuth.instance.currentUser!;

  late Stream<DocumentSnapshot<Map<String, dynamic>>> _stream ;

  late  Stream<Map<String, int>> _map;


   String _location = '';
   @override
  void initState() {
    super.initState();
    getStream();
    getCount();
  }

  getStream() {
    _stream = GetVolunteeringDate().getVolunteeringDate().asyncMap((event) {
      _location = event['location'];
      setState(() {});
      return event;
    });
  }

  getCount() {
    _map = OngoingAndCompletedCount().getCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
                alignment: Alignment.center,
                children: [
              Positioned(
                top: 0,
                child: Container(
                  height: 175.w,
                  width: 397.h,
                  color: kColorPrimary,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 18.w, horizontal: 25.w),
                    child: Text('Profile', style: kStyleWhite22600),
                  ),
                ),
              ),
              Column(
                  children: [
                82.verticalSpace,
                  SizedBox(
                    height: 173.h,
                    width: 280.w,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: 137.h,
                            width: 280.w,
                            decoration: BoxDecoration(
                              color: kColorWhite,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          child: CircleAvatar(
                            radius: 34,
                            child: Image.asset('assets/images/pp.png'),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Column(
                            children: [
                              10.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(_auth.displayName.toString(), style: kStyleBlack12600),
                                  SizedBox(width: 6.w),
                                  GestureDetector(
                                      onTap: (){
                                        Get.to(() => const EditScreen());
                                      },
                                      child: SvgPicture.asset('assets/images/editProfile.svg')
                                  ),
                                ],
                              ),
                              13.verticalSpace,
                              Text(_auth.email.toString(), style: kStyleGrey10500),
                              13.verticalSpace,
                              StreamBuilder(
                                  stream: _stream,
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData){
                                      return  Center(
                                          child: SizedBox(height: 16.h,));}
                                    if (snapshot.hasError) return const Text('.');
                                    final data = snapshot.data!;
                                    return RichText(
                                        text: TextSpan(
                                            text: 'Volunteering Since ',
                                            style: kStyleGrey10500,
                                            children: [
                                              TextSpan(text: data['volunteeringSince'], style: kStylePrimary10700),
                                            ]));
                                  }),

                              27.verticalSpace,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                27.verticalSpace,
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 28.w),
                    child: Column(
                      children: [
                        StreamBuilder(
                            stream: _map,
                            builder: (context, snapshot) {
                              if (!snapshot.hasData){
                                return  Row(
                                  children: [
                                    const CountCard(
                                        text: 'Ongoing count', count: ''),
                                    23.horizontalSpace,
                                    const CountCard(
                                        text: 'Completed count', count: ''),
                                  ],
                                );}
                              if (snapshot.hasError) return const Text('.');
                              final data = snapshot.data!;
                              return Row(
                                children: [
                                  CountCard(
                                      text: 'Ongoing count', count: data['onGoing'].toString()),
                                  23.horizontalSpace,
                                  CountCard(
                                      text: 'Completed count', count: data['completed'].toString()),
                                ],
                              );
                            }),
                        20.verticalSpace,
                        LocationCard(location: _location),
                        20.verticalSpace,
                        const LanguageCard(languages: 'English, French'),
                        35.verticalSpace,
                        const CustomButton(),
                      ],
                    ))
              ]),
            ]),
          ],
        ),
      )),
    );
  }
}
