import 'package:backyard_delivery/cubits/deliveryHistory/deliveryHistoryCubit.dart';
import 'package:backyard_delivery/cubits/notification/notification_cubit.dart';
import 'package:backyard_delivery/cubits/termsAndConditions/termsAndConditonsCubit.dart';
import 'package:backyard_delivery/services/localstroage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'cubits/availableDelivery/availiableDeliveryCubit.dart';
import 'screens/splash_screen/splash_screen.dart';

// import 'screens/splash_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  LocalStorage.init().then((v){
    if(  LocalStorage.getData(key: "Lang")==null)
      LocalStorage.saveData(key: "Lang", value: "en");
  });
  await EasyLocalization.ensureInitialized();



  runApp(EasyLocalization(
      path: 'assets/translations',
      fallbackLocale:LocalStorage.getData(key: "Lang")=="en"?Locale("en","US"):Locale("ar","AR"),
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'AR')],
      child: MyApp()));

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(1080, 2400),
        builder: () =>
            MultiBlocProvider(

                providers: [BlocProvider(create: (BuildContext contex)=>
        AvailiableDeliveryCubit()
      ..getDeliveryList(context)),
    BlocProvider(create: (BuildContext contex)=>TermsAndConditonsCubit()..getTerms(context)),
    BlocProvider(
    create: (context)=>NotificationCubit()..getNotification(context)),
    BlocProvider(create: (BuildContext contex)=>DeliveryHistoryCubit()..getHistory(context,1)),

    ],
    child: MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    title: 'backyard',
    debugShowCheckedModeBanner: false,
    theme:
    ThemeData(primarySwatch: Colors.brown, canvasColor: Colors.white),
    home: SplashScreen(),
    ),
    ),
    );
  }
}
