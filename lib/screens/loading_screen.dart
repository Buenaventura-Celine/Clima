import 'package:flutter/material.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=d5fba74a0b4816bea1cd5bfefceeb87f'));
    if (response.statusCode == 200) {
      String data = response.body;

      var decodedData = jsonDecode(data);

      double temperature = decodedData['main']['temp'];
      int condition = decodedData['weather'][0]['id'];
      String cityName = decodedData['name'];

      print(temperature);
      print(condition);
      print(cityName);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }
}
