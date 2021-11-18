import 'package:backyard_delivery/cubits/deliveryHistory/deliveryHistoryCubit.dart';
import 'package:backyard_delivery/cubits/notification/notification_cubit.dart';
import 'package:backyard_delivery/cubits/termsAndConditions/termsAndConditonsCubit.dart';
import 'package:backyard_delivery/services/diohelper.dart';
import 'package:backyard_delivery/services/localstroage.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'cubits/availableDelivery/availiableDeliveryCubit.dart';
import 'screens/splash_screen/splash_screen.dart';

// import 'screens/splash_screen.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

late AndroidNotificationChannel channel;

late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  LocalStorage.init().then((v) {
    if (LocalStorage.getData(key: "Lang") == null)
      LocalStorage.saveData(key: "Lang", value: "en");
  });
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      path: 'assets/translations',
      fallbackLocale: LocalStorage.getData(key: "Lang") == "en"
          ? Locale("en", "US")
          : Locale("ar", "AR"),
      supportedLocales: [Locale('en', 'US'), Locale('ar', 'AR')],
      child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _requestPermissions() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(LocalStorage.getData(key: "deviceToken")!=null) {
      FirebaseMessaging.instance.getToken().then((value) {
        String? token = value;
        print("FireBaseToken    " + token.toString());
        DioHelper.postData(
            endpoint: "/api/user/fcm",
            context: context,
            formData: {"fcm": token});
      });
    }
    _requestPermissions();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        print("massage sent");
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });
    //saldh

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(1080, 2400),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext contex) =>
                  AvailiableDeliveryCubit()..getDeliveryList(context)),
          BlocProvider(
              create: (BuildContext contex) =>
                  TermsAndConditonsCubit()..getTerms(context)),
          BlocProvider(
              create: (context) =>
                  NotificationCubit()..getNotification(context)),
          BlocProvider(
              create: (BuildContext contex) =>
                  DeliveryHistoryCubit()..getHistory(context, 1)),
        ],
        child: MaterialApp(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Backyard_Delivery',
          debugShowCheckedModeBanner: false,
          theme:
              ThemeData(primarySwatch: Colors.brown, canvasColor: Colors.white),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
