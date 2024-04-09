import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:volunteer_application/AppConstants/AppConstants.dart';
import 'package:volunteer_application/AuthScreens/AuthCustomWidgets.dart';
import 'package:volunteer_application/AuthScreens/sign_up_screen.dart';

import '../AppConstants/utilis.dart';
import '../NavBar/NavigationBar.dart';
import '../repository/auth/sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoading = false;
  final _key = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    email.dispose();
    password.dispose();
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
                  27.verticalSpace,
                  Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sign In',
                        style: kStyleBlack32600,
                      ),
                      16.verticalSpace,
                      Text(
                        'welcome back',
                        style: kStyleGrey14400,
                      ),
                      26.verticalSpace,
                      Form(
                        key: _key,
                        child: Column(
                          children: [
                            CustomLabeledTextField(
                              controller: email, labelText: 'Email', passwordField: false,
                              validator: validateEmail,
                            ),
                            11.verticalSpace,
                            CustomLabeledTextField(
                                controller: password,
                                labelText: 'Password',
                                validator: validatePasswordSignIn,
                                passwordField: true),
                          ],
                        ),
                      ),

                      40.verticalSpace,
                      CustomButton(
                          text: 'Login',
                          isLoading: isLoading,
                          onPressed: () {
                           signIn();
                          },
                          color: kColorPrimary),
                      20.verticalSpace,
                      Row(
                        children: [
                          Text(
                            'Don\'t have an account?',
                            style: kStyleBlack14400,
                          ),
                          5.horizontalSpace,
                          GestureDetector(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SignUpScreen() ), (route) => false);
                            },
                            child: Text(
                              'Sign Up',
                              style: kStyleBlack14700,
                            ),
                    )
                  ],
                )
              ],
            ),
                    ),
                  ]),
          )),
    );
  }

  //functions
  signIn(){
    if (_key.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      SignIn().signIn(
        email: email.text,
        password: password.text,
      ).then((value) {
        if(value == 'success'){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const BottomNavBar()), (route) => false);
          isLoading = false;
          setState(() {});
        }
        else{
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
  }// sign in

}
