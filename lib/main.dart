import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pembekalan_flutter/translations/codegen_loader.g.dart';
import 'package:pembekalan_flutter/utilities/routes.dart';
import 'package:pembekalan_flutter/views/dashboardscreen.dart';
import 'package:pembekalan_flutter/views/loginscreen.dart';
import 'package:pembekalan_flutter/views/registerscreen.dart';
import 'package:pembekalan_flutter/views/splashscreen.dart';
import 'package:pembekalan_flutter/views/submenu/cameragaleryscreen.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailimagescreen.dart';
import 'package:pembekalan_flutter/views/submenu/detail/detailmahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/imagingsliderscreen.dart';
import 'package:pembekalan_flutter/views/submenu/inputdatamahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/listmahasiswascreen.dart';
import 'package:pembekalan_flutter/views/submenu/locationservicesscreen.dart';
import 'package:pembekalan_flutter/views/submenu/mapservicescreen.dart';
import 'package:pembekalan_flutter/views/submenu/ocrscreen.dart';
import 'package:pembekalan_flutter/views/submenu/parsingdatascreen.dart';
import 'package:pembekalan_flutter/views/submenu/updatedatamahasiswascreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  //runApp(const MainApp());

  runApp(EasyLocalization(
    // run this command on terminal to generate localizations assets
    // to add new text, please use i18n manager (open source tools)
    // flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations"
    // flutter pub run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

    child: MainApp(),
    supportedLocales: [Locale('en'), Locale('id')],
    path: 'assets/translations',
    startLocale: Locale('id'), // default locale language (https://www.npmjs.com/package/i18n-iso-countries)
    fallbackLocale: Locale('id'), //
    assetLoader: CodegenLoader(),
  ));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // lock orientasi layar menjadi Portrait Up
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // untuk menghilangkan banner debug
      title: 'Pembekalan Flutter 2025',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: SplashScreen(),
      routes: {
        Routes.splashscreen: (context) => SplashScreen(),
        Routes.loginscreen: (context) => LoginScreen(),
        Routes.registerscreen: (context) => RegisterScreen(),
        Routes.dashboardscreen: (context) => DashboardScreen(),
        Routes.parsingdatascreen: (context) => ParsingDataScreen(),
        Routes.imagingsliderscreen: (context) => ImagingSliderScreen(),
        Routes.detailimagescreen: (context) => DetailImageScreen(),
        Routes.cameragaleryscreen: (context) => CameraGaleryScreen(),
        Routes.listmahasiswascreen: (context) => ListMahasiswaScreen(),
        Routes.inputdatamahasiswascreen: (context) =>
            InputDataMahasiswaScreen(),
        Routes.detailmahasiswascreen: (context) => DetailMahasiswaScreen(),
        Routes.updatedatamahasiswascreen: (context) =>
            UpdateDataMahasiswaScreen(),
        Routes.locationservicesscreen: (context) => LocationServicesScreen(),
        Routes.mapservicescreen: (context) => MapServiceScreen(),
        Routes.ocrscreen: (context) => OCRScreen(),
      },
    );
  }
}
