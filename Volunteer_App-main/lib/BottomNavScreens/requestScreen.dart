import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/Screens/CompletedScreen.dart';
import 'package:volunteer_application/Screens/OnGoingScreen.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key});

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2, animationDuration: null);
    _tabController.addListener(() {
       setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 69.h,
            width: 397.w,
            color: kColorPrimary,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 18.w),
              child: Text("Request", style: kStyleWhite22600),
            ),
          ),
          23.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 30.h,
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    tabAlignment: TabAlignment.start,
                    splashFactory: NoSplash.splashFactory,
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    indicator: const BoxDecoration(),
                    dividerHeight: null,
                    dividerColor: Colors.transparent,
                    padding: EdgeInsets.zero,
                    onTap: (index) {
                      setState(() {
                        // _isOngoingSelected = index == 0;
                      });
                    },
                    tabs: [
                  Tab(
                  child: Container(
                  width: 104.w,
                    height: 30.h,
                    margin: EdgeInsets.only(right: 15.w ),
                    decoration: BoxDecoration(
                      color: _tabController.index == 0 ? kColorPrimary : kColorWhite,
                      borderRadius: BorderRadius.circular(39.r),
                    ),
                    child: Center(
                      child: Text(
                        'Ongoing',
                        style: _tabController.index == 0 ? kStyleWhite11500 : kStyleBlack11500,
                      ),
                    ),
                  ),
            ),

                      Tab(
                        child: Container(
                          width: 104.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                            color: _tabController.index == 0 ? kColorWhite : kColorPrimary,
                            borderRadius: BorderRadius.circular(39.r),
                          ),
                          child: Center(
                            child: Text(
                              'Completed',
                              style: _tabController.index == 0 ? kStyleBlack11500 : kStyleWhite11500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: TabBarView(
                controller: _tabController,
                physics: const BouncingScrollPhysics(),
                children: const [
                  OnGoingScreen(),
                  CompletedScreen(),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
