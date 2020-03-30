import 'package:weather/core/constants.dart';
import 'package:weather/core/daos/base_dao.dart';
import 'package:weather/features/weather/data/model/weather_model.dart';

class WeatherDao extends BaseDao<WeatherModel> {
  WeatherDao()
      : super(
          BOX_WEATHER,
          (c) => c.toJson(),
          (json) => WeatherModel.fromJson(json),
          (c) => c.city.id.toString(),
        );
}
