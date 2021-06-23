import 'package:backyard_delivery/shared/components/components.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactScreen extends StatelessWidget {
  var emailController = TextEditingController();
  var titleController = TextEditingController();
  var massController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color(0xffB09B87)));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffB09B87),
        appBar: customisedAppBar(
          context,
          false,
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Padding(
            padding:
                EdgeInsets.symmetric(vertical: 0.03.sh, horizontal: 0.03.sw),
            child: Container(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'البريد الإلكتروني',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 40.sp, color: Color(0xffB09B87)),
                    ),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      label: 'البريد الإلكتروني',
                      // hint: 'البريد الإلكتروني',
                    ),
                    Text(
                      'المحتوي',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 40.sp, color: Color(0xffB09B87)),
                    ),
                    defaultFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      label: 'المحتوي',
                      // hint: 'البريد الإلكتروني',
                    ),
                    Text(
                      'الرسالة',
                      textAlign: TextAlign.right,
                      style:
                          TextStyle(fontSize: 40.sp, color: Color(0xffB09B87)),
                    ),
                    defaultFormField(
                        controller: massController,
                        type: TextInputType.text,
                        hint: 'الرجاء الكتابة هنا',
                        maxLines: 6),
                    SizedBox(height: .05.sh),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xffB09B87),
                          ),
                          height: .07.sh,
                          width: .39.sw,
                          child: Center(
                              child: Text(
                            'إرسال',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                    Container(
                      height: .25.sh,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
