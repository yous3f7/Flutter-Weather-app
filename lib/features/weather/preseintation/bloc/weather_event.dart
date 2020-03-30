import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}
class FetchWeatherEvent extends WeatherEvent{
  final CancelToken cancelToken;

  FetchWeatherEvent({this.cancelToken});
  @override
  List<Object> get props => [cancelToken];
}