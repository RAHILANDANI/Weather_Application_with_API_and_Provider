import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class getstart extends StatefulWidget {
  const getstart({super.key});

  @override
  State<getstart> createState() => _getstartState();
}

class _getstartState extends State<getstart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/getstart.jpg"), fit: BoxFit.fill),
        ),
        alignment: Alignment.bottomRight,
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setBool('getstart', true).then(
                        (value) =>
                            Navigator.pushReplacementNamed(context, 'homepage'),
                      );
                },
                child: Text("Start"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
