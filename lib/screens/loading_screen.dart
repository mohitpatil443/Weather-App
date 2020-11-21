import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';
import 'location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


const Apikey = '5b549ec0d48a8a9f7ade2380f171f5a8';

//1]Getting the current location by geolocator
//2]Make an http request to the openweather api to get the json data on the basis of lat and long
//3]Parse the data and display on the screen


class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //A separate class called loctionnm accesses the getlocation and stores the
  //latitudes and longitudes in the locationm object
  //We can access the location latitudes and longitudes by getters.



  @override
  void initState() {
    super.initState();
    getData();

  }

  void getData() async{
    WeatherModel weatherModel = WeatherModel();
    var jsonData = await weatherModel.getLocationData();
    print(jsonData);

    Navigator.push(context,MaterialPageRoute(builder: (context) {
      return LocationScreen(jsonData);
    }));

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }



}
