import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheater/provider/api_provider.dart';
import 'package:wheater/views/homescreen.dart';
import 'package:wheater/views/splashscreen.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(
    MultiProvider(
      providers: [
        Provider(
          create: (context) => ApiProvider(),
        )
      ],
      builder: (context, child) => MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => splash(),
          'homepage': (context) => MyApp(),
        },
      ),
    ),
  );
}
