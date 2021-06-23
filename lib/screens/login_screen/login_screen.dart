// import 'package:backyard/widgets/layout_screen.dart';
import 'package:backyard_delivery/layout/layout_screen.dart';
import 'package:backyard_delivery/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 0.1.sh),
          child: Center(
            child: Column(
              children: [
                Image.asset('assets/images/logo.png'),
                SizedBox(
                  height: 0.05.sh,
                ),
                Text(
                  'Let\'s sign you in !',
                  style: TextStyle(fontSize: 50.sp, color: Color(0xff80392C)),
                ),
                SizedBox(
                  height: 0.025.sh,
                ),
                Stack(
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/Group 8208.png'),
                      ],
                    ),
                    Positioned(
                      right: 20,
                      top: .3.sh,
                      child: Column(
                        children: [
                          Container(
                            child: defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              label: 'Email Address',
                              prefix: Icons.email_outlined,
                            ),
                            width: .54.sw,
                            height: .05.sh,
                          ),
                          SizedBox(height: 15.h),
                          Container(
                            child: defaultFormField(
                              controller: passwordController,
                              type: TextInputType.visiblePassword,
                              label: 'password',
                              prefix: Icons.lock_outlined,
                            ),
                            width: .54.sw,
                            height: .05.sh,
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      child: Container(
                        height: 0.05.sh,
                        width: 0.32.sw,
                        child: defaultTextButton(
                            function: () {
                              navigateAndFinish(context, NavigationBar());
                            },
                            title: 'Go'),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xffB09B87),
                        ),
                      ),
                      right: 60.w,
                      bottom: .08.sh,
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.025.sh,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: 'Once you log in, you agree to the ',
                    style: TextStyle(
                        fontSize: 40.sp, color: Colors.brown.shade600),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'terms and conditions',
                        style: TextStyle(
                            color: Colors.brown.shade300,
                            fontSize: 40.sp,
                            decoration: TextDecoration.underline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
