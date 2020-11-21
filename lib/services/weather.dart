import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';
import 'package:weather/utilities/constants.dart';



class WeatherModel {


  Future<dynamic> getCityWeather(city) async{
    NetworkHelper networkHelper = NetworkHelper('https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric');
    var data = await networkHelper.getData();
    return data;
  }

  dynamic getLocationData() async {
    Locationm loc = Locationm();
    await loc.getLocation();

    return requestData(loc);
  }


  //Async is used to get the location details in background
  //It is run on separate thread
  //Hence it is concurrent and await is used in order to first execute the function and then
  //assign it to position variable


  //Cannot make initState as async

  dynamic requestData(loc) async {
    NetworkHelper networkHelper = NetworkHelper(
        'https://api.openweathermap.org/data/2.5/weather?lat=${loc
            .latitude}&lon=${loc.longitude}&appid=$apiKey&units=metric');
    return await networkHelper.getData();
  }


    String getWeatherIcon(int condition) {
      if (condition < 300) {
        return '🌩';
      } else if (condition < 400) {
        return '🌧';
      } else if (condition < 600) {
        return '☔️';
      } else if (condition < 700) {
        return '☃️';
      } else if (condition < 800) {
        return '🌫';
      } else if (condition == 800) {
        return '☀️';
      } else if (condition <= 804) {
        return '☁️';
      } else {
        return '🤷‍';
      }
    }

    String getMessage(int temp) {
      if (temp > 25) {
        return 'It\'s Ice-Cream time';
      } else if (temp > 20) {
        return 'Nice Weather';
      } else if (temp < 10) {
        return 'Cold Times';
      } else {
        return 'Avoid Being';
      }
    }
  }
