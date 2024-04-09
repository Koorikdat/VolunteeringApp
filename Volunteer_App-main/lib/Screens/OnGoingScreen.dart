import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/BottomNavScreens/requestCustomWidgets.dart';
import 'package:volunteer_application/repository/user_requests/user_requests.dart';

import '../repository/models/user_requests_model.dart';

class OnGoingScreen extends StatelessWidget {
  const OnGoingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 48.h),
      child: Column(children: [
        Expanded(
          child: StreamBuilder(
              stream: UserRequests().userRequests('InProgress'),
              builder: (context, snapshot) {
                if (!snapshot.hasData){
                  return const Center(
                      child: CircularProgressIndicator());}
                if (snapshot.hasError) return const Text('Error');
                final data = snapshot.data!.docs;
                return ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final UserRequestsModel model = UserRequestsModel.fromMap(data[index].data());
                      return RequestTile(
                       model: model,
                        style: kStyleYellow11500,
                      );
                    });
              }),
        ),

      ]),
    );
  }
}
