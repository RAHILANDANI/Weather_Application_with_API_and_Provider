import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheater/provider/api_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var pov = Provider.of<ApiProvider>(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/cloud.jpg"), fit: BoxFit.fill),
        ),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  "My Location",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                pov.location['name'],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              Container(
                height: 60,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                        "http:${pov.current['condition']['icon']}"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                "${pov.current['temp_c']}",
                style: TextStyle(fontSize: 70, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
