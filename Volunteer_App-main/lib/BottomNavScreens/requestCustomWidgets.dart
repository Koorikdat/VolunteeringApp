import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/repository/models/user_requests_model.dart';

class RequestTile extends StatelessWidget {
  final UserRequestsModel model;
  final TextStyle style;

  const RequestTile(
      {super.key,
      required this.model,
      required this.style,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 12.h),
      child: Container(
        width: 348.w,
        height: 68.h,
        decoration: BoxDecoration(
          color: kColorWhite,
          borderRadius: BorderRadius.circular(5.r)
        ),
        padding: EdgeInsets.only(left: 15.w, right: 10.w, bottom: 5.h, top: 5.h),
        child: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/locationBlue.svg'),
                25.horizontalSpace,
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 180.w,
                      child: Text(
                        model.address1,
                        style: kStyleBlack12500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    4.verticalSpace,
                    SizedBox(
                      width: 180.w,
                      child: Text(
                        model.address2,
                        style: kStyleBlack10500,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.time,
                  style: kStyleBlack16500,
                ),
                8.verticalSpace,
                Text(
                  model.status,
                  style: style,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
