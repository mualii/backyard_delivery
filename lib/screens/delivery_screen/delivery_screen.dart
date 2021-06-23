import 'package:backyard_delivery/screens/DetailsProduct_Screen/DetailsProduct_Screen.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DeliveryScreen extends StatelessWidget {
  const DeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Color(0xffB09B87),
        appBar: customisedAppBar(context, false),
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.03.sh, horizontal: 0.03.sw),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.separated(
                        // primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) =>
                            InDeliverdBuilder(context: context, index: index),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: 2,
                      ),
                      Divider(),
                      ListView.separated(
                        primary: false,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => HasDeliveredBuild(),
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: 5,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget HasDeliveredBuild() {
    return Center(
        child: Container(
      height: .15.sh,
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Color(0xffB09B87), width: .5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'تم التوصيل',
                    style: TextStyle(fontSize: 40.sp, color: Color(0xff80392C)),
                  ),
                  Opacity(
                    opacity: .4,
                    child: Text(
                      '05 : 30 PM',
                      style:
                          TextStyle(fontSize: 40.sp, color: Colors.grey[400]),
                    ),
                  ),
                ],
              ),
              Spacer(),
              Opacity(
                opacity: .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '59585',
                          style: TextStyle(
                              fontSize: 40.sp, color: Colors.grey[400]),
                        ),
                        Text(
                          '    :  طلب رقم     ',
                          style: TextStyle(
                              color: Color(0xff80392C), fontSize: 40.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ' عبدالله فرج',
                          style: TextStyle(
                              fontSize: 40.sp, color: Colors.grey[400]),
                        ),
                        Text(
                          ' :  إسم العميل    ',
                          style: TextStyle(
                              color: Color(0xff80392C), fontSize: 40.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  Widget InDeliverdBuilder(
      {required int index, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => DetailsProduct_Screen()));
      },
      child: Container(
        height: .2.sh,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xffB09B87), width: .5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Spacer(),
                    Text(
                      '05 : 30 PM',
                      style:
                          TextStyle(fontSize: 40.sp, color: Colors.grey[400]),
                    ),
                  ],
                ),
                Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          '59585',
                          style: TextStyle(
                              fontSize: 40.sp, color: Colors.grey[400]),
                        ),
                        Text(
                          '    :  طلب رقم     ',
                          style: TextStyle(
                              color: Color(0xff80392C), fontSize: 40.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          ' عبدالله فرج',
                          style: TextStyle(
                              fontSize: 40.sp, color: Colors.grey[400]),
                        ),
                        Text(
                          ' :  إسم العميل    ',
                          style: TextStyle(
                              color: Color(0xff80392C), fontSize: 40.sp),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '966 0214 588 +',
                          style: TextStyle(
                              fontSize: 40.sp, color: Colors.grey[400]),
                        ),
                        Text(
                          '    :  الجوال     ',
                          style: TextStyle(
                              color: Color(0xff80392C), fontSize: 40.sp),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
