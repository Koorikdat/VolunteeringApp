import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/AuthScreens/AuthCustomWidgets.dart';
import 'package:volunteer_application/repository/auth/edit_name.dart';

class EditScreen extends StatefulWidget {
  const EditScreen({super.key});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final name = TextEditingController();

   bool isLoading =false;

  String currentName = FirebaseAuth.instance.currentUser!.displayName.toString();

  @override
  void initState() {
    super.initState();
    name.text = currentName;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: 69.w,
            color: kColorPrimary,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              child: Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Get.back();
                      },
                      child: SvgPicture.asset('assets/images/arrowLeft.svg')),
                  45.horizontalSpace,
                  Text('Edit Name', style: kStyleWhite22600),
                ],
              ),
            ),
          ),
          35.verticalSpace,
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                CustomLabeledTextField(
                    labelText: 'Name',
                    color: kColorTextField,
                    radius: 5.r,
                    passwordField: false,
                    controller: name),
                30.verticalSpace,
                CustomButton(
                  isLoading: isLoading,
                    radius: 5.r,
                    isElevation: false,
                    text: 'Update', onPressed: () {
                  setName();
                },
                    color: kColorPrimary3)
              ],
            ),
          )
        ],
      )),
    );
  }

  // Function
  setName(){
    if(name.text != ''){
    if(name.text != currentName){
      isLoading = true;
      setState(() {});
      EditName().editName(name.text).then((value) {
        if(value){
          isLoading = false;
          showSuccessSnackBar(context: context, message: 'Edited Successfully');
          setState(() {});
        }
        else{
          isLoading = false;
          showSuccessSnackBar(context: context, message: 'Failed' , isFailed: true);
          setState(() {});
        }
      });
    }
    }
    else{
      showSuccessSnackBar(context: context, message: 'Enter name', isFailed: true);
    }
  }


}
