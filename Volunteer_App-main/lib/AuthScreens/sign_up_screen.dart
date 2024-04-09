import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/AuthScreens/AuthCustomWidgets.dart';
import 'package:volunteer_application/AuthScreens/sign_in_screen.dart';
import 'package:volunteer_application/NavBar/NavigationBar.dart';

import '../AppConstants/utilis.dart';
import '../repository/auth/sign_up.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 242.h,
                color: kColorPrimary,
                child: Center(
                  child: Image.asset('assets/images/logo.png'),
                ),
              ),
              20.verticalSpace,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: kStyleBlack32600,
                    ),
                    16.verticalSpace,
                    Text(
                      'welcome to volunteering services',
                      style: kStyleGrey14400,
                    ),
                    12.verticalSpace,
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomLabeledTextField(
                            controller: name,
                            labelText: 'Name',
                            validator: validateName,
                            passwordField: false,
                          ),
                          11.verticalSpace,
                          CustomLabeledTextField(
                            controller: email,
                            labelText: 'Email',
                            validator: validateEmail,
                            passwordField: false,
                          ),
                          11.verticalSpace,
                          CustomLabeledTextField(
                            controller: password,
                            labelText: 'Password',
                            validator: validatePassword,
                            passwordField: true,
                          ),
                          11.verticalSpace,
                          CustomLabeledTextField(
                            controller: confirmPassword,
                            labelText: 'Confirm Password',
                            validator: (value){
                              if (value == null || value.isEmpty) {
                                return "Please Re-Enter New Password";
                              }
                              if(value != password.text) {
                                return 'Password must be same as above';
                              }
                              return null;
                            },
                            passwordField: true,
                          ),
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    CustomButton(
                        text: 'Create Account',
                        isLoading: isLoading,
                        onPressed: () {
                         signUp();
                        },
                        color: kColorPrimary),
                    15.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Already have an account?',
                          style: kStyleBlack14400,
                        ),
                        5.horizontalSpace,
                        GestureDetector(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignInScreen() ), (route) => false);
                          },
                          child: Text(
                            'Sign In',
                            style: kStyleBlack14700,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              50.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
  //Function
  signUp(){
    if (_formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      SignUp().signUp(
        email: email.text,
        password: password.text,
        name: name.text,
      ).then((value) {
        if (value == 'success') {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNavBar()), (route) => false);
          isLoading = false;
          setState(() {});
        }
        else {
          showSuccessSnackBar(context: context, message: value, isFailed: true);
          isLoading = false;
          setState(() {});
          debugPrint(value);
        }
      }).onError((error, stackTrace) {
        showSuccessSnackBar(context: context, message: error.toString(), isFailed: true);
        isLoading = false;
        setState(() {});
        debugPrint(error.toString());
      });
    }
    }

  }
