import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';

class CustomLabeledTextField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool passwordField;
  final Color? color;
  final double? radius;
  final String? Function(String?)? validator;

  const CustomLabeledTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.passwordField,
    this.validator,
    this.color,
    this.radius,
  });

  @override
  State<CustomLabeledTextField> createState() => _CustomLabeledTextFieldState();
}

class _CustomLabeledTextFieldState extends State<CustomLabeledTextField> {
  bool passwordVisible = false;
  final _border = OutlineInputBorder(
    borderRadius: BorderRadius.circular( 14.r),
    borderSide: BorderSide.none,
  );
  @override
  Widget build(BuildContext context) {
    return widget.passwordField
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelText,
                style: kStyleBlack14400,
              ),
              11.verticalSpace,
              SizedBox(
                width: 345.w,
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: passwordVisible ? false : true,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: kStyleGrey16400,
                    fillColor: kColorPrimary2,
                    filled: true,
                    enabledBorder: _border,
                    focusedBorder: _border,
                    border: _border,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 17.h, horizontal: 20.w),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(bottom: 1.5.h),
                      child: IconButton(
                          icon: Icon(!passwordVisible
                              ? Icons.visibility_off
                              : Icons.visibility),
                          color: kColorGrey,
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          }),
                    ),
                  ),
                  validator: widget.validator,
                ),
              ),
            ],
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.labelText,
                style: kStyleBlack14400,
              ),
              11.verticalSpace,
              SizedBox(
                width: 345.w,
                child: TextFormField(
                  controller: widget.controller,
                  decoration: InputDecoration(
                    hintText: widget.labelText,
                    hintStyle: kStyleGrey16400,
                    fillColor:  widget.color ?? kColorPrimary2,
                    filled: true,
                    enabledBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular( widget.radius ?? 14.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular( widget.radius ?? 14.r),
                      borderSide: BorderSide.none,
                    ),
                    border:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular( widget.radius ?? 14.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  ),
                  validator: widget.validator,
                ),
              ),
            ],
          );
  }
}
/////-------------------------Button---------------------------/////

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final bool? isLoading;
  final bool? isElevation;
  final double? radius;

  CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color,
      this.isLoading,
      this.radius,
      this.isElevation,
      });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: isElevation == false ? 0 : 5,
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10.r),
      child: Container(
        width: 345.w,
        height: 60.h,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(radius ?? 10.r),
        ),
        child: isLoading == true
            ? const Center(
              child: CircularProgressIndicator(
                  color: kColorWhite,
                ),
            )
            : TextButton(
                onPressed: onPressed,
                child: Text(text, style: kStyleWhite16600),
              ),
      ),
    );
  }
}

// --------------- Snack Bar --------------//
void showSuccessSnackBar(
    {required BuildContext context,
    required String message,
    bool isFailed = false}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      content: Container(
        height: 56.h,
        width: 367.w,
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.symmetric(horizontal: 15.h),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            color: !isFailed ? kColorPrimary2 : kColorRed.withOpacity(0.4)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 285.w,
              child: Text(
                message,
                // overflow: TextOverflow.ellipsis,
                style: !isFailed
                    ? kStylePrimary13500
                    : kStylePrimary13500.copyWith(color: kColorDarkRed),
              ),
            ),
            Icon(
              !isFailed ? Icons.check_circle : Icons.info,
              color: !isFailed ? kColorPrimary2 : kColorDarkRed.withOpacity(0.5),
            ),
          ],
        ),
      ),
      duration: const Duration(seconds: 1),
    ),
  );
}
