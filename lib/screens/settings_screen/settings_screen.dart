import 'package:backyard_delivery/screens/contact_screen/contant_screen.dart';
import 'package:backyard_delivery/screens/previous_orders_screen/previous_orders_screen.dart';
import 'package:backyard_delivery/screens/terms_screen/terms_screen.dart';
import 'package:backyard_delivery/shared/components/components.dart';
import 'package:backyard_delivery/shared/widgets/customised_appBar.dart';
import 'package:backyard_delivery/shared/widgets/search_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

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
        body: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          ),
          child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 0.03.sh, horizontal: 0.03.sw),
              child: Center(
                child: Column(
                  children: [
                    SearchTextField(),
                    DefaultItemButton(
                      context: context,
                      title: 'My previous orders',
                      image: 'assets/images/back button.png',
                      Ontap: () {
                        navigateTo(context, PreviousOrdersScreen());
                      },
                    ),
                    DefaultItemButton(
                      context: context,
                      title: 'Terms and Conditions',
                      image: 'assets/images/back button.png',
                      Ontap: () {
                        navigateTo(context, TermsScreen());
                      },
                    ),
                    DefaultItemButton(
                      context: context,
                      title: 'CONTACT',
                      image: 'assets/images/back button.png',
                      Ontap: () {
                        navigateTo(context, ContactScreen());
                      },
                    ),
                    DefaultItemButton(
                      context: context,
                      title: 'language',
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
                      child:
                          defaultTextButton(function: () {}, title: 'LOG OUT'),
                      alignment: Alignment.bottomRight,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Widget changeLanguage(context) {
    return CupertinoActionSheet(
      title: Text('Language'),
      message: Column(
        children: [
          Text('Choose your language'),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CupertinoActionSheetAction(
                child: Column(
                  children: [
                    Image.asset("assets/images/united-kingdom.png"),
                    Text('English'),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoActionSheetAction(
                child: Column(
                  children: [
                    Image.asset("assets/images/saudi-arabia.png"),
                    Text('Arabic'),
                  ],
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          )
        ],
      ),
      cancelButton: CupertinoActionSheetAction(
        child: Text('cancel'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    );
  }
}
