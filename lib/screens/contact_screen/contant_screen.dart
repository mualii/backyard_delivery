import 'package:backyard_delivery/services/diohelper.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContactScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ContactScreenState();
  }
}

class ContactScreenState extends State<ContactScreen> {
  var emailController = TextEditingController();
  var titleController = TextEditingController();
  var massController = TextEditingController();
  bool emailChecker = false, titleChecker = false, massageChcker = false;
  checkEmpty() {
    if (emailController.text == "")
      setState(() {
        emailChecker = true;
      });
    else
      emailChecker = false;
    if (titleController.text == "")
      setState(() {
        titleChecker = true;
      });
    else
      titleChecker = false;
    if (massController.text == "")
      setState(() {
        massageChcker = true;
      });
    else
      massageChcker = false;
    if (emailChecker == false &&
        massageChcker == false &&
        titleChecker == false)
      DioHelper.postData(
              endpoint: "/api/messages/send",
              formData: {
                "from": emailController.text,
                "subject": titleController.text,
                "body": massController.text
              },
              context: context)
          .then((value) {
        Navigator.of(context).pop();
      });
  }

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
          true,
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Email Address'.tr(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 45.sp, color: Color(0xff80392C)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContantCartFormField(
                          checker: emailChecker,
                          controller: emailController,
                          type: TextInputType.emailAddress,
                          hint: 'Email Address'.tr(),
                          maxLines: 1,
                        ),
                        emailChecker == false
                            ? Container()
                            : Text(
                                "Please enter email".tr(),
                                style: TextStyle(color: Colors.red),
                              )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'subject'.tr(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 45.sp, color: Color(0xff80392C)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContantCartFormField(
                          checker: titleChecker,
                          controller: titleController,
                          type: TextInputType.text,
                          hint: 'subject'.tr(),
                          maxLines: 1,
                        ),
                        emailChecker == false
                            ? Container()
                            : Text(
                                "Please enter subject".tr(),
                                style: TextStyle(color: Colors.red),
                              )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          'Message'.tr(),
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              fontSize: 45.sp, color: Color(0xff80392C)),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ContantCartFormField(
                          checker: massageChcker,
                          controller: massController,
                          type: TextInputType.text,
                          maxLines: 6,
                          hint: 'Write here'.tr(),
                        ),
                        emailChecker == false
                            ? Container()
                            : Text(
                                "Please enter message".tr(),
                                style: TextStyle(color: Colors.red),
                              )
                      ],
                    ),
                    SizedBox(height: .05.sh),
                    InkWell(
                      onTap: () {
                        checkEmpty();
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
                            'send'.tr(),
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

  Widget ContantCartFormField({
    required TextEditingController controller,
    required TextInputType type,
    String? hint,
    bool? checker,
    int? maxLines,
  }) {
    return Card(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
          side: checker == true
              ? BorderSide(width: 1, color: Colors.red)
              : BorderSide(width: 0),
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TextFormField(
              maxLines: maxLines,
              controller: controller,
              keyboardType: type,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hint,
                hintStyle: TextStyle(
                  fontSize: 15,
                ),
              )),
        ));
  }

  void ShowDilog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        content: Container(
          margin: EdgeInsets.only(top: 50.w),
          child: Column(
            children: [
              RowText(title: ' طلب رقم', content: "152421"),
              RowText(title: ' تاريخ التوصيل', content: '2021 / 05 / 18'),
              RowText(title: ' الميعاد', content: '05 : 30 PM'),
              RowText(title: ' إسم العميل', content: 'عبد الله فرج'),
              RowText(title: 'عنوان العميل', content: '+966 5441 7114'),
              SizedBox(
                height: 50.h,
              ),
              Container(
                padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                child: Text(
                  'عنوان العميل',
                  style: TextStyle(
                      color: Color(0xff80392C),
                      fontWeight: FontWeight.bold,
                      fontSize: 60.sp),
                ),
              ),
              Container(
                height: .4.sh,
                width: 1.sw,
                child: Image.asset(
                  'assets/images/Group 8218.png',
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                height: 50.h,
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.fromLTRB(24.0, 0, 24.0, 24),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Color(0xffB09B87)),
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          height: .065.sh,
                          width: .3.sw,
                          child: Center(
                              child: Text(
                            'تجاهل',
                            style: TextStyle(color: Color(0xffB09B87)),
                          )),
                        ),
                      ),
                    ),
                    Spacer(),
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
                          height: .065.sh,
                          width: .3.sw,
                          child: Center(
                              child: Text(
                            'إستلام',
                            style: TextStyle(color: Colors.white),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget RowText({required String content, required String title}) {
    return Container(
      padding: EdgeInsets.fromLTRB(18.0, 0, 18, 0),
      child: Row(
        //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 350.w,
            alignment: Alignment.center,
            child: Text(
              content,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Color(0xffB9B9B9), fontWeight: FontWeight.bold),
            ),
          ),
          Spacer(),
          Container(
            child: Text(
              " : ",
              style: TextStyle(
                  color: Color(0xff80392C),
                  fontWeight: FontWeight.bold,
                  fontSize: 60.sp),
              textAlign: TextAlign.end,
            ),
          ),
          Container(
            width: 310.w,
            child: Text(
              title,
              style: TextStyle(
                  color: Color(0xff80392C),
                  fontWeight: FontWeight.bold,
                  fontSize: 60.sp),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }
}
