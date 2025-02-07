import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:weather_app/weatherModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool _getWeatherInProgress = false;
  final TextEditingController _cityNameTEController=TextEditingController();
  final GlobalKey<FormState> _key=GlobalKey<FormState>();
  List<WeatherModel> weatherDetails=[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.grey.shade300,
      appBar: AppBar(
        title: const Text(
          "Weather Application",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Visibility(
        visible: _getWeatherInProgress==false,
        replacement: const Center(
          child: CircularProgressIndicator(),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Form(
                  key: _key,
                  child: TextFormField(
                    controller: _cityNameTEController,
                    keyboardType:TextInputType.text,
                    decoration: const InputDecoration(
                      hintText: "Dhaka",
                      labelText: "Enter City Name"
                    ),
                    validator: (String? value){
                      if(value==null || value.trim().isEmpty){
                        return "Enter a Valid City Name";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(onPressed: (){
                  if(_key.currentState!.validate()){
                    _getWeatherDetails();
                  }
                }, child:const Text("Get Forecast")),
                const SizedBox(height: 10,),
                Card(
                  color: Colors.lightBlue,
                  child: weatherDetails.isEmpty ? const ListTile(title: Text("No Data Available")) :
                  ListTile(
                    title: Text('Weather Details of ${weatherDetails[0].cityName} city',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: DefaultTextStyle(
                      style: const TextStyle(color: Colors.black, fontSize: 16),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: 130,
                                height: 130,
                                child: Image.network(
                                  'https://cdn.pixabay.com/photo/2012/04/18/13/21/clouds-37009_640.png',
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stackTrace) {
                                    return const SizedBox(
                                      width: 50,
                                      child: Icon(Icons.broken_image),
                                    );
                                    },
                                ),
                              ),
                            ),
                            const SizedBox(height: 30,),
                            Text("Time zone: ${weatherDetails[0].timezone}"),
                            Text("Description: ${weatherDetails[0].description}"),
                            Text("Temperature: ${weatherDetails[0].temperature.toStringAsFixed(2)}°C"),
                            Text("Feels Like: ${weatherDetails[0].feelsLike.toStringAsFixed(2)} °C"),
                            Text("Humidity: ${weatherDetails[0].humidity} %"),
                            Text("Wind Speed: ${weatherDetails[0].windSpeed} Km/H"),
                            Text("Pressure: ${weatherDetails[0].pressure} hPa"),
                            Text("seaLevel: ${weatherDetails[0].seaLevel} hPa"),
                            Text("sunrise: ${weatherDetails[0].sunrise}"),
                            Text("sunset: ${weatherDetails[0].sunset}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


void _timezoneConvert(){
    String time=weatherDetails[0].timezone;
    double t=double.tryParse(time)?? 0;
    t=t/3600;
    weatherDetails[0].timezone=t.toString();
}

void _sunSet(){
  int timestamp =int.tryParse(weatherDetails[0].sunset)??0;
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  DateTime cityTime = dateTime.add(Duration(hours:int.tryParse(weatherDetails[0].timezone)??0));
  weatherDetails[0].sunset = DateFormat('hh:mm:ss a').format(cityTime);
}

void _sunRise(){
  int timestamp =int.tryParse(weatherDetails[0].sunrise)??0;
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  DateTime cityTime = dateTime.add(Duration(hours:int.tryParse(weatherDetails[0].timezone)??0));
  weatherDetails[0].sunrise = DateFormat('hh:mm:ss a').format(cityTime);
}

  Future<void> _getWeatherDetails() async {
    _getWeatherInProgress=true;
    setState(() {});
    weatherDetails.clear();
    String apiKey="39ac2de89e032bd84c5974aeff8bd863";
    String weatherApiURL="https://api.openweathermap.org/data/2.5/weather?q=${_cityNameTEController.text.toLowerCase()}&appid=$apiKey";
    Uri uri=Uri.parse(weatherApiURL);
    Response response=await get(uri);
    if(response.statusCode==200){
      final decodedData=jsonDecode(response.body);
      WeatherModel weatherInfo = WeatherModel.fromJson(decodedData);
      weatherDetails.add(weatherInfo);
      _timezoneConvert();
      _sunSet();
      _sunRise();
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Wrong City Name")));
    }
    setState(() {});
    _getWeatherInProgress=false;
  }
}
