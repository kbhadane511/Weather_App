import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherFactory _wf = WeatherFactory(openWeatherApiKey);
  Weather? _weather;

  @override
  void initState() {
    super.initState();
    _wf.currentWeatherByCityName("jammu").then((w){
      setState(() {
        _weather=w;        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildUI(),);
  }

  Widget _buildUI(){
    if(_weather==null){
      return const Center(
        child: CircularProgressIndicator(),
        );
    }
     return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _locationHeader(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.08,
          ),
          _dateTimeInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.05,
          ),
          _weatherIcon(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.02,
          ),
          _currentTemp(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.02,
          ),
           _extraInfo(),
          SizedBox(
            height: MediaQuery.sizeOf(context).height*0.02,
          ),
        ],
      ),
     );
  }
  Widget _locationHeader(){
    return Text( _weather?.areaName ?? "",
    style: const TextStyle(fontSize: 20.0,fontWeight: FontWeight.w700),);
  }

  Widget _dateTimeInfo(){
    DateTime now = _weather!.date!;
    return Column(children: [
      Text(DateFormat("h:mm a").format(now),
      style: const TextStyle(fontSize: 35),
      ),
      const SizedBox(height: 35,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            DateFormat("EEEE").format(now),
            style: const TextStyle(fontWeight: FontWeight.w700),
            ),

            Text(
            " ${DateFormat("d.m.y").format(now)}",
            style: const TextStyle(fontWeight: FontWeight.w700),
            ),

        ],
      )
    ],
    );
  }

  Widget _weatherIcon(){
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.sizeOf(context).height*0.25,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage("https://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png"),
            ),
          ),
        ),

        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _currentTemp(){
    return Text("${_weather?.temperature?.celsius?.toStringAsFixed(1)}  ℃",
    style: const TextStyle(
      color: Colors.black,
      fontSize: 85,
      fontWeight: FontWeight.w500,
    ),
    );
  }
  Widget _extraInfo(){
    return Container(
      width: MediaQuery.sizeOf(context).width*0.80,
      height: MediaQuery.sizeOf(context).height*0.15,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(
        8.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(1)}  ℃",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                ),
              ),
              
              Text("Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(1)}  ℃",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                ),
              ),
              
              Text("Humidity: ${_weather?.humidity?.toStringAsFixed(0)} %",
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

      ],),
    );
  }
}