import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/api_provider.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  bool? res;

  @override
  void initState() {
    getstart();
    // TODO: implement initState
    super.initState();
    getdata(context).then(
      (value) {
        Timer(
          Duration(seconds: 3),
          () {
            (res == true)
                ? Navigator.of(context).pushReplacementNamed('homepage')
                : Navigator.of(context).pushReplacementNamed('getstart');
          },
        );
      },
    );
  }

  getstart() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    res = pref.getBool('getstart');
  }

  Future<void> getdata(BuildContext context) async {
    await Provider.of<ApiProvider>(context, listen: false).fetchdataapi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/splashimage.jpg"),
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
