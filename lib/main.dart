import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheater/provider/api_provider.dart';
import 'package:wheater/provider/theme_provider.dart';
import 'package:wheater/views/get_started.dart';
import 'package:wheater/views/homescreen.dart';
import 'package:wheater/views/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiProvider(),
        ),
        Provider(
          create: (context) => ThemeProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        themeMode:
            (Provider.of<ThemeProvider>(context).themeModel.isdark == false)
                ? ThemeMode.light
                : ThemeMode.dark,
        initialRoute: '/',
        routes: {
          '/': (context) => splash(),
          'homepage': (context) => MyApp(),
          'getstart': (context) => getstart(),
        },
      ),
    ),
  );
}
