import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/core/errors/base_error.dart';
import 'package:weather/features/weather/domain/entity/weather_entity.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class InitialWeatherState extends WeatherState {
  @override
  List<Object> get props => [];
}

class LoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class SuccessState extends WeatherState {
  final WeatherEntity data;

  SuccessState({@required this.data});

  @override
  List<Object> get props => [data];
}

class FailureState extends WeatherState {
  final BaseError error;
  final VoidCallback callback;

  FailureState({
    this.error,
    this.callback,
  }) : assert(error != null);

  @override
  List<Object> get props => [
        error,
        callback,
      ];
}
