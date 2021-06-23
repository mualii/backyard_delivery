import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsProduct_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB09B87),
      appBar: customisedAppBar(context, true),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.03.sh, horizontal: 0.03.sw),
                child: Text(
                  'تفاصيل التوصيل',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 70.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff80392C)),
                ),
              ),
              Container(
                height: .4.sh,
                width: 1.sw,
                child: Image.asset(
                  "assets/images/Map.png",
                  fit: BoxFit.fill,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.03.sh, horizontal: 0.03.sw),
                child: Container(
                  width: 0.4.sw,
                  child: Text(
                    'شقة رقم 604 عقار السلام الطابق السادس',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 50.sp, color: Color(0xff80392C)),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '+966 5441 7114',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 50.sp, color: Color(0xffB9B9B9)),
                    ),
                    SizedBox(
                      width: 30.w,
                    ),
                    Text(
                      ': الجوال',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 50.sp, color: Color(0xff80392C)),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.01.sh, horizontal: 0.03.sw),
                child: Text(
                  'محتويات الطلب',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 50.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff80392C)),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 50.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                color: Color(0xffF6F6F6),
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 30.h),
                      child: Row(
                        children: [
                          Expanded(child: Text("Beef Burger x1")),
                          Text(
                            "16 SAR",
                            style: TextStyle(fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 50.h, bottom: 50.h),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                    ),
                    Container(
                      width: 700.w,
                      height: 280.h,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20))),
                        elevation: 8,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '230',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 50.sp,
                                      color: Color(0xffB9B9B9)),
                                ),
                                SizedBox(
                                  width: 30.w,
                                ),
                                Text(
                                  ': الإجمالي ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 50.sp,
                                      color: Color(0xff80392C)),
                                ),
                              ],
                            ),
                            Text(
                              'الدفع عند الإستلام',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffB9B9B9)),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 100.w,
                      child: CircleAvatar(
                        radius: 110.r,
                        backgroundColor: Color(0xff80392C),
                        child: Center(
                          child: Container(
                            width: 180.w,
                            child: Text(
                              "ريال سعودي ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
                child: Text(
                  'معلومات إضافية',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 60.sp,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff80392C)),
                ),
              ),
              Text(
                'لا يوجد أي معلومات إضافية للعميل',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 50.sp, color: Color(0xffB9B9B9)),
              ),
              SizedBox(
                height: 50.h,
              ),
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
                    height: .076.sh,
                    width: .65.sw,
                    child: Center(
                        child: Text(
                      'تم التوصيل',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ),
              ),
              SizedBox(
                height: 50.h,
              )
            ],
          ),
        ),
      ),
    );
  }
}
