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
      backgroundColor: const Color.fromARGB(255, 11, 86, 93),
      body: Container(
        padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: const Column(children: [
            WeatherTitle(),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ListWeather(
                    time: '2:00 AM', temperature: '10°', image: 'assets/1.png'),
                ListWeather(
                    time: '12:00 AM', temperature: '9°', image: 'assets/2.png'),
                ListWeather(
                    time: '18:00 PM', temperature: '11°', image: 'assets/3.png')
              ],
            ),
            Spacer(),
            Spacer()
          ]),
        ),
      ),
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
              // height: MediaQuery.of(context).size.height,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${state.weather.areaName}',
                      style: const TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    Text(
                      greeting(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 50),
                    Center(
                        child: Column(children: [
                      Text(
                        '${state.weather.weatherMain}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                          '${DateFormat('EEE dd · hh.mma').format(state.weather.date ?? DateTime.now())}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 14))
                    ])),
                    const SizedBox(height: 10),
                    Container(
                        height: 200,
                        child: Stack(children: [
                          Align(
                              alignment: const AlignmentDirectional(0, -2.8),
                              child: ShaderMask(
                                shaderCallback: (Rect rect) {
                                  return const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [Colors.transparent, Colors.white],
                                    stops: [0.2, 1.2],
                                  ).createShader(rect);
                                },
                                blendMode: BlendMode.dstOut,
                                child: Text(
                                  '${state.weather.temperature!.celsius!.round()}°',
                                  overflow: TextOverflow.fade,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 120,
                                      fontWeight: FontWeight.w700),
                                ),
                              )),
                          Align(
                              alignment: const AlignmentDirectional(0, 2),
                              child: getWeatherIcon(
                                  state.weather.weatherConditionCode!))
                        ]))
                  ]));
        } else {
          return const Center(child: CircularProgressIndicator());
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

class ListWeather extends StatelessWidget {
  final String image;
  final String time;
  final String temperature;
  const ListWeather(
      {super.key,
      required this.time,
      required this.temperature,
      required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(height: 50, child: Image.asset(image)),
      Text(time,
          style: const TextStyle(
              color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500)),
      Text(temperature,
          style: const TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700))
    ]);
  }
}
