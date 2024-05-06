import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:today_is_today/bloc/weather_bloc.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(children: [
            Background(),
            WeatherTitle(),
          ]),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional(10, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(-10, -0.3),
          child: Container(
            height: 300,
            width: 300,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple),
          ),
        ),
        Align(
          alignment: AlignmentDirectional(0, -1.3),
          child: Container(
            height: 300,
            width: 600,
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: Colors.orange),
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
          child:
              Container(decoration: BoxDecoration(color: Colors.transparent)),
        ),
      ],
    );
  }
}

class WeatherTitle extends StatelessWidget {
  const WeatherTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherSuccess) {
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.weather.areaName}',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      greeting(),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 50),
                    getWeatherIcon(state.weather.weatherConditionCode!),
                    SizedBox(height: 50),
                    Center(
                        child: Column(children: [
                      Text(
                        '${state.weather.temperature!.celsius!.round()}°C',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 50,
                            fontWeight: FontWeight.w700),
                      ),
                      Text(
                        '${state.weather.weatherMain}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                          '${DateFormat('EEE dd · hh.mma').format(state.weather.date ?? DateTime.now())}',
                          style: TextStyle(color: Colors.grey, fontSize: 14))
                    ]))
                  ]));
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  }
  if (hour < 17) {
    return 'Good Afternoon';
  }
  return 'Good Evening';
}

Widget getWeatherIcon(int icon) {
  switch (icon) {
    case > 200 && <= 300:
      return Image.asset(
        'assets/1.png',
      );
    default:
      return Image.asset(
        'assets/3.png',
        fit: BoxFit.fill,
      );
  }
}
