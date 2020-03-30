import 'package:weather/core/models/BaseModel.dart';
import 'package:weather/features/weather/domain/entity/weather_entity.dart';

import 'enum.dart';

class WeatherModel extends BaseModel<WeatherEntity>{
  final String cod;
  final int message;
  final int cnt;
  final List<ListElementModel> list;
  final CityModel city;

  WeatherModel({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });


  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
    cod: json["cod"] == null ? null : json["cod"],
    message: json["message"] == null ? null : json["message"],
    cnt: json["cnt"] == null ? null : json["cnt"],
    list: json["list"] == null ? null : List<ListElementModel>.from(json["list"].map((x) => ListElementModel.fromJson(x))),
    city: json["city"] == null ? null : CityModel.fromJson(json["city"]),
  );

  Map<String, dynamic> toJson() => {
    "cod": cod == null ? null : cod,
    "message": message == null ? null : message,
    "cnt": cnt == null ? null : cnt,
    "list": list == null ? null : List<dynamic>.from(list.map((x) => x.toJson())),
    "city": city == null ? null : city.toJson(),
  };

  @override
  WeatherEntity toEntity() => WeatherEntity(city: this.city.toEntity(),cnt: this.cnt,list: this.list.map((l)=>l.toEntity()).toList());
}

class CityModel extends BaseModel<City>{
  final int id;
  final String name;
  final Coord coord;
  final String country;
  final int timezone;
  final int sunrise;
  final int sunset;

  CityModel({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.timezone,
    this.sunrise,
    this.sunset,
  });


  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"] == null ? null : json["id"],
    name: json["name"] == null ? null : json["name"],
    coord: json["coord"] == null ? null : Coord.fromJson(json["coord"]),
    country: json["country"] == null ? null : json["country"],
    timezone: json["timezone"] == null ? null : json["timezone"],
    sunrise: json["sunrise"] == null ? null : json["sunrise"],
    sunset: json["sunset"] == null ? null : json["sunset"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "name": name == null ? null : name,
    "coord": coord == null ? null : coord.toJson(),
    "country": country == null ? null : country,
    "timezone": timezone == null ? null : timezone,
    "sunrise": sunrise == null ? null : sunrise,
    "sunset": sunset == null ? null : sunset,
  };

  @override
  City toEntity() => City(name: this.name,country: this.country,sunrise: this.sunrise,sunset: this.sunset,timezone: this.timezone);
}

class Coord {
  final double lat;
  final double lon;

  Coord({
    this.lat,
    this.lon,
  });


  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
  };
}

class ListElementModel extends BaseModel<ListElement>{
  final int dt;
  final MainClassModel main;
  final List<WeatherMod> weather;
  final Clouds clouds;
  final WindModel wind;
  final Sys sys;
  final DateTime dtTxt;
  final Rain rain;

  ListElementModel({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.sys,
    this.dtTxt,
    this.rain,
  });



  factory ListElementModel.fromJson(Map<String, dynamic> json) => ListElementModel(
    dt: json["dt"] == null ? null : json["dt"],
    main: json["main"] == null ? null : MainClassModel.fromJson(json["main"]),
    weather: json["weather"] == null ? null : List<WeatherMod>.from(json["weather"].map((x) => WeatherMod.fromJson(x))),
    clouds: json["clouds"] == null ? null : Clouds.fromJson(json["clouds"]),
    wind: json["wind"] == null ? null : WindModel.fromJson(json["wind"]),
    sys: json["sys"] == null ? null : Sys.fromJson(json["sys"]),
    dtTxt: json["dt_txt"] == null ? null : DateTime.parse(json["dt_txt"]),
    rain: json["rain"] == null ? null : Rain.fromJson(json["rain"]),
  );

  Map<String, dynamic> toJson() => {
    "dt": dt == null ? null : dt,
    "main": main == null ? null : main.toJson(),
    "weather": weather == null ? null : List<dynamic>.from(weather.map((x) => x.toJson())),
    "clouds": clouds == null ? null : clouds.toJson(),
    "wind": wind == null ? null : wind.toJson(),
    "sys": sys == null ? null : sys.toJson(),
    "dt_txt": dtTxt == null ? null : dtTxt.toIso8601String(),
    "rain": rain == null ? null : rain.toJson(),
  };

  @override
  ListElement toEntity() => ListElement(dtTxt: this.dtTxt,
      main: this.main.toEntity(),wind: this.wind.toEntity(),
      weather: this.weather.map((w)=>w.toEntity()).toList());
}

class Clouds {
  final int all;

  Clouds({
    this.all,
  });


  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
    all: json["all"] == null ? null : json["all"],
  );

  Map<String, dynamic> toJson() => {
    "all": all == null ? null : all,
  };
}

class MainClassModel extends BaseModel<MainClass>{
  final String temp;
  final double feelsLike;
  final double tempMin;
  final double tempMax;
  final int pressure;
  final int seaLevel;
  final int grndLevel;
  final String humidity;
  final double tempKf;

  MainClassModel({
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

  factory MainClassModel.fromJson(Map<String, dynamic> json) => MainClassModel(
    temp: json["temp"] == null ? null : (json["temp"].toDouble() -273.15).toInt().toString(),
    feelsLike: json["feels_like"] == null ? null : json["feels_like"].toDouble(),
    tempMin: json["temp_min"] == null ? null : json["temp_min"].toDouble(),
    tempMax: json["temp_max"] == null ? null : json["temp_max"].toDouble(),
    pressure: json["pressure"] == null ? null : json["pressure"],
    seaLevel: json["sea_level"] == null ? null : json["sea_level"],
    grndLevel: json["grnd_level"] == null ? null : json["grnd_level"],
    humidity: json["humidity"] == null ? null : json["humidity"].toString()+"%",
    tempKf: json["temp_kf"] == null ? null : json["temp_kf"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "temp": temp == null ? null : temp,
    "feels_like": feelsLike == null ? null : feelsLike,
    "temp_min": tempMin == null ? null : tempMin,
    "temp_max": tempMax == null ? null : tempMax,
    "pressure": pressure == null ? null : pressure,
    "sea_level": seaLevel == null ? null : seaLevel,
    "grnd_level": grndLevel == null ? null : grndLevel,
    "humidity": humidity == null ? null : humidity,
    "temp_kf": tempKf == null ? null : tempKf,
  };

  @override
  MainClass toEntity() => MainClass(
    feelsLike: this.feelsLike,grndLevel: this.grndLevel,
    humidity: this.humidity,pressure: this.pressure,
    seaLevel: this.seaLevel,temp: this.temp,tempKf: this.tempKf,
    tempMax: this.tempMax,tempMin: this.tempMin,
  );
}

class Rain {
  final double the3H;

  Rain({
    this.the3H,
  });


  factory Rain.fromJson(Map<String, dynamic> json) => Rain(
    the3H: json["3h"] == null ? null : json["3h"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "3h": the3H == null ? null : the3H,
  };
}

class Sys {
  final Pod pod;

  Sys({
    this.pod,
  });


  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
    pod: json["pod"] == null ? null : podValues.map[json["pod"]],
  );

  Map<String, dynamic> toJson() => {
    "pod": pod == null ? null : podValues.reverse[pod],
  };
}


final podValues = EnumValues({
  "d": Pod.D,
  "n": Pod.N
});

class WeatherMod extends BaseModel<Weather>{
  final int id;
  final MainEnum main;
  final Description description;
  final String icon;

  WeatherMod({
    this.id,
    this.main,
    this.description,
    this.icon,
  });


  factory WeatherMod.fromJson(Map<String, dynamic> json) => WeatherMod(
    id: json["id"] == null ? null : json["id"],
    main: json["main"] == null ? null : mainEnumValues.map[json["main"]],
    description: json["description"] == null ? null : descriptionValues.map[json["description"]],
    icon: json["icon"] == null ? null : json["icon"],
  );

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "main": main == null ? null : mainEnumValues.reverse[main],
    "description": description == null ? null : descriptionValues.reverse[description],
    "icon": icon == null ? null : icon,
  };

  @override
  Weather toEntity() => Weather(main: this.main,description: this.description,icon: this.icon);
}




class WindModel extends BaseModel<Wind>{
  final String speed;
  final int deg;

  WindModel({
    this.speed,
    this.deg,
  });

  factory WindModel.fromJson(Map<String, dynamic> json) => WindModel(
    speed: json["speed"] == null ? null : json["speed"].toString()+"km/h",
    deg: json["deg"] == null ? null : json["deg"],
  );

  Map<String, dynamic> toJson() => {
    "speed": speed == null ? null : speed,
    "deg": deg == null ? null : deg,
  };

  @override
  Wind toEntity() => Wind(deg: this.deg,speed: this.speed);
}
