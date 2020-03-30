import 'package:weather/core/errors/base_error.dart';
import 'package:weather/core/results/result.dart';
import 'package:weather/core/usecases/usecase.dart';
import 'package:weather/features/weather/domain/entity/weather_entity.dart';
import 'package:weather/features/weather/domain/param/weather_param.dart';
import 'package:weather/features/weather/domain/repository/weather_repository.dart';

class WeatherUseCase extends UseCase<WeatherEntity, WeatherParams> {
  final WeatherRepository repository;

  WeatherUseCase({this.repository});

  @override
  Future<Result<BaseError, WeatherEntity>> call(WeatherParams params) async {
    return await repository.getWeatherData(
      query: WeatherParams(id: params.id,appId: params.appId).toJson(),
      cancelToken: params.cancelToken,
    );
  }
}
