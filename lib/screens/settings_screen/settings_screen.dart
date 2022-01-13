import 'package:backyard_delivery/cubits/deliveryHistory/deliveryHistoryCubit.dart';
import 'package:backyard_delivery/main.dart';
import 'package:backyard_delivery/screens/contact_screen/contant_screen.dart';
import 'package:backyard_delivery/screens/login_screen/login_screen.dart';
import 'package:backyard_delivery/screens/previous_orders_screen/previous_orders_screen.dart';
import 'package:backyard_delivery/screens/splash_screen/splash_screen.dart';
import 'package:backyard_delivery/screens/terms_screen/terms_screen.dart';
import 'package:backyard_delivery/services/localstroage.dart';
import 'package:backyard_delivery/shared/components/components.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:backyard_delivery/shared/widgets/search_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  goEnglish(BuildContext context) async {
   await LocalStorage.saveData(key: "Lang", value: "en");
    await context.setLocale(EasyLocalization.of(context)!.supportedLocales[0]);
    context.setLocale(Locale('en'));
    Navigator.of(context).pop();

    navigateAndFinish(context, MyApp());
  }

  goArabic(BuildContext context) async {
    await LocalStorage.saveData(key: "Lang", value: "ar");
    await context.setLocale(EasyLocalization.of(context)!.supportedLocales[1]);
    context.setLocale(Locale('ar'));
    Navigator.of(context).pop();

    navigateAndFinish(context, MyApp());
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
        appBar: customisedAppBar(context, false),
        body: SingleChildScrollView(
          child: Container(
            height: .769.sh,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            ),
            child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: 0.03.sh, horizontal: 0.03.sw),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 90.h,
                      ),
                      DefaultItemButton(
                        context: context,
                        title: 'My previous orders'.tr(),
                        image: 'assets/images/back button.png',
                        Ontap: () {
                          navigateTo(context, PreviousOrdersScreen());
                        },
                      ),
                      DefaultItemButton(
                        context: context,
                        title: 'Terms and Conditions'.tr(),
                        image: 'assets/images/back button.png',
                        Ontap: () {
                          navigateTo(context, TermsScreen());
                        },
                      ),
                      DefaultItemButton(
                        context: context,
                        title: 'CONTACT'.tr(),
                        image: 'assets/images/back button.png',
                        Ontap: () {
                          navigateTo(context, ContactScreen());
                        },
                      ),
                      DefaultItemButton(
                        context: context,
                        title: 'language'.tr(),
                        image: 'assets/images/back button.png',
                        Ontap: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (BuildContext context) =>
                                  changeLanguage(context));
                        },
                      ),
                      Spacer(),
                      Align(
                        child: defaultTextButton(
                            function: () {
                              LocalStorage.removeData(key: "deviceToken");
                              navigateAndFinish(context, LoginScreen());
                            },
                            title: 'LOG OUT'.tr()),
                        alignment: Alignment.bottomRight,
                      ),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget changeLanguage(context) {
    return CupertinoActionSheet(
      title: Text('Language'.tr()),
      message: Column(
        children: [
          Text('Choose your language'.tr()),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActionSheetAction(
                child: Column(
                  children: [
                    Image.asset("assets/images/united-kingdom.png"),
                    Text('English'.tr()),
                  ],
                ),
                onPressed: () {
                  goEnglish(context);
                  DeliveryHistoryCubit.get(context).getHistory(context, 1);
                },
              ),
              CupertinoActionSheetAction(
                child: Column(
                  children: [
                    Image.asset("assets/images/saudi-arabia.png"),
                    Text('Arabic'.tr()),
                  ],
                ),
                onPressed: () {
                  goArabic(context);
                  DeliveryHistoryCubit.get(context).getHistory(context, 1);
                },
              ),
            ],
          )
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text('cancel'.tr()),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    );
  }
}
