import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as PathProvider;
import 'package:weather/features/weather/data/daos/weather_dao.dart';

abstract class AppDB {
  static Future<void> init() async {
    final docsDirectory = await PathProvider.getApplicationDocumentsDirectory();
    Hive.init(docsDirectory.path);
  }

  static void dispose() async {
    await Hive.close();
  }

  static Future<void> clear() async {
    await WeatherDao().clear();
  }
}
