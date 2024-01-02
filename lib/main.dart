import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hotfocus/presentation/welcome_screen/welcome_screen.dart';
import '../presentation/app_intro_screen/app_intro_screen.dart';

import '../routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'data/providers/user_provider.dart';
import 'firebase_options.dart';
import 'localization/app_localization.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await Firebase.initializeApp();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  cameras = await availableCameras();
  await MobileAds.instance.initialize();
  RequestConfiguration configuration =
      RequestConfiguration(testDeviceIds: ["602DD4E57D93CD25BA37122EAD0AF8F5"]);
  MobileAds.instance.updateRequestConfiguration(configuration);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => UserProvider())],
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        translations: AppLocalization(),
        locale: Get.deviceLocale,
        //for setting localization strings
        fallbackLocale: const Locale('en', 'US'),
        title: 'Hotfocus',
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  const AppIntroScreen();
            }
            if (snapshot.hasData) {
              return const WelcomeScreen();
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
        initialRoute: AppRoutes.welcomeScreen,
        getPages: AppRoutes.pages,
      ),
    );
  }
}
