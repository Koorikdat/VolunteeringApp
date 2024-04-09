import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/AuthScreens/sign_in_screen.dart';
import 'package:volunteer_application/Screens/EditScreen.dart';
import 'package:volunteer_application/repository/get_volunteering_date.dart';

////////////////////////////////CountCard/////////////////////////////////////
class CountCard extends StatelessWidget {
  final String text;
  final String count;
  const CountCard({super.key, required this.text, required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 158.w,
      height: 110.h,
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: text == 'Completed count' ? kColorWhite.withOpacity(0.5) : kColorWhite,
        borderRadius: BorderRadius.circular(5.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          3.verticalSpace,
          Text(text, style: kStyleGrey9700),
          7.verticalSpace,
          Text(count, style: kStylePrimary37700),
        ],
      ),
    );
  }
}

////////////////////////////////LocationCard/////////////////////////////////////
class LocationCard extends StatelessWidget {
  final String location;
  const LocationCard({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 349.w,
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: kColorWhite,
        borderRadius: BorderRadius.circular(5.r)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/images/locationProfile.svg'),
          22.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("From", style: kStyleGrey9700),
              2.verticalSpace,
              SizedBox(
                  width: 200.w,
                  child: Text(location, style: kStylePrimary18700, overflow: TextOverflow.ellipsis,)),
            ],
          )
        ],
      ),
    );
  }
}

////////////////////////////////LanguageCard/////////////////////////////////////
class LanguageCard extends StatelessWidget {
  final String languages;
  const LanguageCard({super.key, required this.languages});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: 349.w,
      padding: EdgeInsets.symmetric(vertical: 17.h, horizontal: 16.w),
      decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.circular(5.r)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/images/languageProfile.svg',
          ),
          22.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Speaks", style: kStyleGrey9700),
              2.verticalSpace,
              Row(
                children: [
                  Text('English', style: kStylePrimary18700),
                  20.horizontalSpace,
                  const Icon(Icons.circle, size: 5, color: kColorGrey145,),
                  20.horizontalSpace,
                  Text('Urdu', style: kStylePrimary18700),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

////////////////////////////////CustomButton/////////////////////////////////////
class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FirebaseAuth.instance.signOut();
        Get.to(() => const SignInScreen());
      },
      child: Container(
        width: 349.w,
        height: 60.h,
        decoration: BoxDecoration(
            color: kColorWhite,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(width: 1, color: kColorRed)),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/logoutProfile.svg'),
            10.horizontalSpace,
            Text(
              'Log out',
              style: kStyleRed12400,
            )
          ],
        )),
      ),
    );
  }
}
