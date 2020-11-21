import 'package:flutter/material.dart';
import 'package:weather/screens/city_screen.dart';
import 'package:weather/services/weather.dart';
import 'package:weather/utilities/constants.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen(this.jsonData);

  final jsonData;
  @override
  _LocationScreenState createState() => _LocationScreenState();
}


class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weatherModel = WeatherModel();

  int temperature;
  int condition;
  String suggest;
  String icon;
  String city;


  @override
  void initState() {
    super.initState();
    updateUI(widget.jsonData);
  }

  void updateUI(dynamic data){
    setState(() {
      temperature = data['main']['temp'].toInt();
      condition = data['weather'][0]['id'].toInt();
      icon = weatherModel.getWeatherIcon(condition);
      suggest = weatherModel.getMessage(temperature);
      city = data['name'];

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: () async{
                        var data = await weatherModel.getLocationData();
                        print(data);
                        updateUI(data);

                    },
                    child: Icon(
                      Icons.near_me,
                      size: 30.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () async{
                      var cityName = await Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      }));

                      if(cityName != null){
                        var data = await weatherModel.getCityWeather(cityName);
                        updateUI(data);

                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      '$temperature°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '$icon',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "$suggest in $city",
                  textAlign: TextAlign.center,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
