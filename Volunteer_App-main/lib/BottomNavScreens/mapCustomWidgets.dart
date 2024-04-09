import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/NavBar/NavigationBar.dart';
import 'package:volunteer_application/repository/all_requests/on_accept_request.dart';
import 'package:volunteer_application/repository/models/all_requests_model.dart';
import '../repository/all_requests/get_all_requests.dart';

class MapRequestTile extends StatefulWidget {
  String? id;
  MapRequestTile({
    Key? key,
    this.id,
  }) : super(key: key);

  @override
  _MapRequestTileState createState() => _MapRequestTileState();
}

class _MapRequestTileState extends State<MapRequestTile> {
  int selectedIndex = -1;

  late Stream<QuerySnapshot<Map<String, dynamic>>> _stream;

  @override
  void initState() {
    super.initState();
    getStream();
  }

  getStream() {
    _stream = GetAllRequests().getAllRequests();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableBottomSheet(
      alignment: Alignment.topLeft,
      backgroundWidget: Container(
        width: 397.w,
        color: kColorWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/Base.png'),
              22.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Requests',
                    style: kStyleBlack20600,
                  ),
                ],
              ),
              14.verticalSpace,
              Expanded(
                child: StreamBuilder(
                    stream: _stream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) return const Text('Error');
                      final data = snapshot.data!.docs;
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            final AllRequestsModel model =
                                AllRequestsModel.fromMap(data[index].data());
                            if (model.id == widget.id) {
                              selectedIndex = index;
                            }
                            return Padding(
                              padding: EdgeInsets.only(bottom: 14.h),
                              child: GestureDetector(
                                onTap: () {
                                    selectedIndex = index;
                                    widget.id = model.id;
                                    CameraPosition position = CameraPosition(
                                        target: LatLng(model.lat, model.lng),
                                        zoom: 14);
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => BottomNavBar(
                                              position: position,
                                              id: model.id,
                                            )),
                                            (route) => false);
                                },
                                child: Container(
                                  width: 348.w,
                                  height: 85.h,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 5.h),
                                  decoration: BoxDecoration(
                                    color: selectedIndex == index
                                        ? kColorPrimary
                                        : kColorWhite,
                                    borderRadius: BorderRadius.circular(5.r),
                                    border: selectedIndex != index
                                        ? Border.all(
                                            width: 1.5.w,
                                            color: kColorShadow,
                                          )
                                        : null,
                                  ),
                                  child: Row(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          selectedIndex == index
                                              ? SvgPicture.asset(
                                                  'assets/images/locationWhite.svg')
                                              : SvgPicture.asset(
                                                  'assets/images/locationBlue.svg'),
                                          25.horizontalSpace,
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: 160.w,
                                                child: Text(
                                                  model.address1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: selectedIndex == index
                                                      ? kStyleWhite12500
                                                      : kStyleBlack12500,
                                                ),
                                              ),
                                              4.verticalSpace,
                                              SizedBox(
                                                width: 160.w,
                                                child: Text(
                                                  model.address2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: selectedIndex == index
                                                      ? kStyleWhite10500
                                                      : kStyleBlack10500,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const Spacer(),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            model.time,
                                            style: selectedIndex == index
                                                ? kStyleWhite16500
                                                : kStyleBlack16500,
                                          ),
                                          7.verticalSpace,
                                          GestureDetector(
                                            onTap: () {
                                              OnAcceptRequest()
                                                  .onAcceptRequest(model);
                                            },
                                            child: Container(
                                              width: 65.w,
                                              height: 30.h,
                                              decoration: BoxDecoration(
                                                color: selectedIndex == index
                                                    ? kColorWhite
                                                    : kColorPrimary,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        38.89.r),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Accept',
                                                  style: selectedIndex == index
                                                      ? kStylePrimary11500
                                                      : kStyleWhite11500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
      expandedWidget: const SizedBox(),
      previewWidget: const SizedBox(),
      onDragging: (double offset) {},
    );
  }
}
