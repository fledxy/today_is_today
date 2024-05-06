import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<WeatherEvent>((event, emit) async {
      try {
        WeatherFactory wf = WeatherFactory("7720c7654c4c815bb47a1dd6dc4e5efb",
            language: Language.VIETNAMESE);

        Position position = await Geolocator.getCurrentPosition();

        Weather weather = await wf.currentWeatherByLocation(
            position.latitude, position.longitude);
        print(weather);

        emit(WeatherSuccess(weather));
      } catch (error) {
        emit(WeatherFailure());
      }
    });
  }
}
