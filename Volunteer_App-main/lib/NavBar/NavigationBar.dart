import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/BottomNavScreens/mapScreen.dart';
import 'package:volunteer_application/BottomNavScreens/profile.dart';
import 'package:volunteer_application/BottomNavScreens/requestScreen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    this.position,
    this.id,
  });
  final CameraPosition? position;
  final String? id;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int currentIndex = 0;

  void changeIndex(int newIndex) {
    setState(() {
      currentIndex = newIndex;
    });
  }


  @override

  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 0 ?
      MapScreen(cameraPosition:widget.position, id: widget.id)
      : currentIndex == 1?
        const RequestScreen()
        : const ProfileScreen(),
      bottomNavigationBar: SizedBox(
        // height: 60.h,
        child: BottomNavigationBar(
          backgroundColor: kColorPrimary,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: kColorWhite,
          unselectedItemColor: kColorWhite,
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: kStyleWhite11500,
          elevation: 0,
          currentIndex: currentIndex,
          onTap: (index) {
            changeIndex(index);
          },
          items: [
            BottomNavigationBarItem(
                activeIcon: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/mapIcon.svg'),
                    SizedBox(width: 5.h),
                    Text(
                      'Map',
                      style: kStyleWhite11500,
                    ),
                  ],
                ),
                icon: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/mapIconGrey.svg',
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      'Map',
                      style: kStyleWhite11500,
                    ),
                  ],
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/requestsIconGrey.svg',
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      'Requests',
                      style: kStyleWhite11500,
                    ),
                  ],
                ),
                activeIcon: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/requestsIcon.svg',
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      'Requests',
                      style: kStyleWhite11500,
                    ),
                  ],
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/profileIconGrey.svg',
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      'Profile',
                      style: kStyleWhite11500,
                    ),
                  ],
                ),
                activeIcon: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/profileIcon.svg',
                    ),
                    SizedBox(width: 5.h),
                    Text(
                      'Profile',
                      style: kStyleWhite11500,
                    ),
                  ],
                ),
                label: ''),
          ],
        ),
      ),
    );
  }
}
