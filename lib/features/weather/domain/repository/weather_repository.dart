import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather/core/errors/base_error.dart';
import 'package:weather/core/repositories/repository.dart';
import 'package:weather/core/results/result.dart';
import 'package:weather/features/weather/data/daos/weather_dao.dart';
import 'package:weather/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';
import 'package:weather/features/weather/domain/entity/weather_entity.dart';

class WeatherRepository extends Repository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepository({this.remoteDataSource});

  Future<Result<BaseError, WeatherEntity>> getWeatherData({
    @required Map<String, dynamic> query,
    CancelToken cancelToken,
  }) async {
    final remoteResult = await remoteDataSource.getWeatherFromApi(
      query: query,
      cancelToken: cancelToken,
    );
    return executeWithCacheRemoteFirst<
        WeatherModel, WeatherEntity, WeatherDao>(
      remoteResult: remoteResult,
      dao: WeatherDao(),
      duration: const Duration(days: 1)
    );
  }
}
