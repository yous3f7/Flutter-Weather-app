import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/core/datasources/remote_data_source.dart';
import 'package:weather/core/errors/base_error.dart';
import 'package:weather/core/http/api_url.dart';
import 'package:weather/core/http/http_method.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';

class WeatherRemoteDataSource extends RemoteDataSource{
  Future<Either<BaseError, WeatherModel>> getWeatherFromApi({
    @required Map<String, dynamic> query,
    CancelToken cancelToken,
  }) {
    return request<WeatherModel, dynamic>(
      converter: (json) => WeatherModel.fromJson(json),
      method: HttpMethod.GET,
      url: API_WEATHER_URL,
      queryParameters: query,
      cancelToken: cancelToken,
    );
  }
}