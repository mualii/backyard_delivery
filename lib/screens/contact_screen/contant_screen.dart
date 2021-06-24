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
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: .68.sw,
                        ),
                        Text(
                          'البريد الإلكتروني',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 45.sp, color: Color(0xff80392C)),
                        ),
                      ],
                    ),
                    ContantCartFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      hint: 'البريد الإلكتروني',
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: .8.sw,
                        ),
                        Text(
                          'المحتوي',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 45.sp, color: Color(0xff80392C)),
                        ),
                      ],
                    ),
                    ContantCartFormField(
                      controller: titleController,
                      type: TextInputType.text,
                      hint: 'المحتوي',
                      maxLines: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: .8.sw,
                        ),
                        Text(
                          'الرسالة',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 45.sp, color: Color(0xff80392C)),
                        ),
                      ],
                    ),
                    ContantCartFormField(
                      controller: massController,
                      type: TextInputType.text,
                      maxLines: 6,
                      hint: 'الرجاء الكتابة هنا',
                    ),
                    SizedBox(height: .05.sh),
                    InkWell(
                      onTap: () {
                        ShowDilog(context);
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

  Widget ContantCartFormField({
    required TextEditingController controller,
    required TextInputType type,
    String? hint,
    int? maxLines,
  }) {
    return Card(
        color: Colors.grey[300],
        shape: RoundedRectangleBorder(
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
                hintTextDirection: TextDirection.rtl,
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
