import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:wheater/model/temperature_model.dart';

class ApiProvider extends ChangeNotifier {
  Map<String, dynamic> location = {};
  Map<String, dynamic> current = {};
  List forecastday = [];
  List forecastdayhour = [];
  List<TemphourModel> forecastday_model = [];
  List forday = [];
  Map<String, dynamic> forastro = {};

  Future<void> fetchdataapi() async {
    String apikey = "6055c00ec0104cbf81b105446231212";
    String api =
        "http://api.weatherapi.com/v1/forecast.json?key=$apikey&q=rajkot&days=10&aqi=no&alerts=no";

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> fetchedddataapi = jsonDecode(data);
      location = fetchedddataapi['location'];
      current = fetchedddataapi['current'];
      forecastday = fetchedddataapi['forecast']['forecastday'];
      forday = forecastday[0]['hour'];

      // forecastday_model = forecastdayhour
      //     .map((e) => TemphourModel(
      //         imageurl: e['condition']['icon'],
      //         wheatertext: e['condition']['text'],
      //         time: e['time'],
      //         tempc: e['temp_c'],
      //         tempf: e['temp_f'],
      //         windkph: e['wind_mph'],
      //         windmph: e['wind_kph']))
      //     .toList();
      // print(forecastday_model);
    }
    notifyListeners();
  }

  Future<void> searchdata(String searchdata) async {
    String apikey = "6055c00ec0104cbf81b105446231212";

    String api =
        "http://api.weatherapi.com/v1/forecast.json?key=$apikey&q=${searchdata}&days=10&aqi=no&alerts=no";

    http.Response response = await http.get(Uri.parse(api));

    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> fetchedddataapi = jsonDecode(data);
      location = fetchedddataapi['location'];
      current = fetchedddataapi['current'];
      forecastday = fetchedddataapi['forecast']['forecastday'];
    }
    notifyListeners();
  }

  void indexforecast(int index) {
    forday = forecastday[index]['hour'];
    forastro = forecastday[index]['astro'];

    notifyListeners();
  }
}
