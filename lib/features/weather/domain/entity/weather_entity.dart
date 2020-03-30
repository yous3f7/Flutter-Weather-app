import 'package:weather/core/entities/base_entity.dart';
import 'package:weather/features/weather/data/model/enum.dart';

class WeatherEntity extends BaseEntity{
  final int cnt;
  final List<ListElement> list;
  final City city;

  WeatherEntity({
    this.cnt,
    this.list,
    this.city,
  });

  @override
  List<Object> get props => [cnt,list,city];

}

class ListElement extends BaseEntity{
  final MainClass main;
  final Wind wind;
  final List<Weather> weather;
  final DateTime dtTxt;

  ListElement({
    this.wind,
    this.main,
    this.weather,
    this.dtTxt,
  });

  @override
  List<Object> get props => [main,weather,dtTxt,wind];
}

class Wind extends BaseEntity{
  final String speed;
  final int deg;

  Wind({
    this.speed,
    this.deg,
  });

  @override
  List<Object> get props => [speed,deg];
}

class Weather extends BaseEntity{
  final MainEnum main;
  final Description description;
  final String icon;

  Weather({
    this.main,
    this.description,
    this.icon,
  });

  @override
  List<Object> get props => [main,description,icon];
}

class MainClass extends BaseEntity{
  final String temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final String humidity;
  final double tempKf;

  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });

  @override
  List<Object> get props => [temp,feelsLike,tempMin,tempMax,pressure,seaLevel,grndLevel,humidity,tempKf,];
}

class City extends BaseEntity{
  final String name;
  final String country;
  final int timezone;
  final int sunrise;
  final int sunset;

  City({
    this.name,
    this.country,
    this.timezone,
    this.sunrise,
    this.sunset,
  });

  @override
  List<Object> get props => [name,country,timezone,sunrise,sunset,];
}