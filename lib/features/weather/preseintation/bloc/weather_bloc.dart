import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/core/errors/custom_error.dart';
import 'package:weather/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:weather/features/weather/domain/param/weather_param.dart';
import 'package:weather/features/weather/domain/repository/weather_repository.dart';
import 'package:weather/features/weather/domain/usecase/weather_usecase.dart';
import './bloc.dart';

final _remoteDataSource = WeatherRemoteDataSource();
final _repository = WeatherRepository(remoteDataSource: _remoteDataSource);
final _usecase = WeatherUseCase(repository: _repository);

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherEvent) {
      yield LoadingState();
      var response ;
      try {
        response = await _usecase(WeatherParams(
                id: API_ID,
                appId: API_APP_ID,
                cancelToken: event.cancelToken,
              ));
      } catch (e) {
        print(e);
        yield FailureState(error: CustomError(message: "Error"),callback: (){this.add(event);});
      }
      if (response.hasErrorOnly){
        yield FailureState(error: response.error,callback: (){this.add(event);});
      }
      if (response.hasDataOnly){
        yield SuccessState(data: response.data);
      }
    }
  }
}
