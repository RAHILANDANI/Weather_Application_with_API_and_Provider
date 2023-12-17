import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wheater/provider/api_provider.dart';
import 'package:wheater/provider/theme_provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Stream<ConnectivityResult> streamconnectivity;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Connectivity connectivity = Connectivity();
    streamconnectivity = connectivity.onConnectivityChanged;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: streamconnectivity,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data == ConnectivityResult.wifi) {
              return bodywidget();
            } else if (snapshot.data == ConnectivityResult.mobile) {
              return bodywidget();
            } else {
              return Center(
                child: Text(
                  "Oops you are offline",
                  style: TextStyle(fontSize: 22),
                ),
              );
            }
          } else {
            return Text("${snapshot.error}");
          }
        },
      ),
    );
  }

  Widget bodywidget() {
    var pov = Provider.of<ApiProvider>(context);
    return SingleChildScrollView(
      child: Container(
        decoration:
            (Provider.of<ThemeProvider>(context).themeModel.isdark == false)
                ? BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("asset/cloud.jpg"), fit: BoxFit.fill),
                  )
                : BoxDecoration(color: Colors.black54),
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFormField(
                      decoration:
                          InputDecoration(hintText: "search location here"),
                      onChanged: (val) {
                        pov.searchdata(val).then(
                          (value) {
                            setState(() {});
                          },
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconButton(
                      onPressed: () {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .changetheme();
                        setState(() {});
                      },
                      icon: (Provider.of<ThemeProvider>(context)
                                  .themeModel
                                  .isdark ==
                              false)
                          ? Icon(Icons.dark_mode)
                          : Icon(Icons.light_mode),
                    ),
                  )
                ],
              ),
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
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.transparent.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Icon(
                              Icons.air,
                              size: 40,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Text(
                                "${pov.current['wind_mph']}",
                                style: TextStyle(fontSize: 40),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "°",
                                style: TextStyle(fontSize: 40),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Text(
                                "${pov.current['wind_degree']}",
                                style: TextStyle(fontSize: 40),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Text(
                              "Wind Direction",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 100,
                              width: 100,
                              child: Text(
                                "${pov.current['wind_dir']}",
                                style: TextStyle(fontSize: 40),
                              ),
                              alignment: Alignment.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Forecast",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              Container(
                height: 280,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.transparent.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: ListView.builder(
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    pov.indexforecast(index);
                    return ListTile(
                      title: Row(
                        children: [
                          Expanded(
                            child: Text("${pov.forecastday[index]['date']}"),
                          ),
                          Expanded(
                            child: Text("${pov.forday[index]['temp_c']}"),
                          ),
                        ],
                      ),
                      subtitle: Row(
                        children: [
                          Expanded(
                            child: Text("Sunrise - ${pov.forastro['sunrise']}"),
                          ),
                          Expanded(
                            child: Text("Sunset - ${pov.forastro['sunset']}"),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
