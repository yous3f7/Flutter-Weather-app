import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/core/global/CoreStyle.dart';
import 'package:weather/features/weather/data/model/enum.dart';
import 'package:weather/features/weather/preseintation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/preseintation/bloc/weather_event.dart';
import 'package:weather/features/weather/preseintation/bloc/weather_state.dart';
import 'package:weather/features/weather/preseintation/widget/loading_widget.dart';
import 'package:weather/features/weather/preseintation/widget/wind_humidity_widget.dart';

class WeatherPage extends StatefulWidget {
  static const routeName = "/WeatherPage";
  final int selectedDay;

  const WeatherPage({Key key,@required this.selectedDay}) : super(key: key);
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final refreshController = RefreshController();
  final cancelToken = CancelToken();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: CoreStyle.setHeightPercentage(100, context),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Theme.of(context).primaryColor, CoreStyle.actionBlue,Theme.of(context).accentColor],
              ),
            ),
          ),
          BlocBuilder<WeatherBloc,WeatherState>(
            bloc: BlocProvider.of<WeatherBloc>(context),
            builder: (ctx,state){
              if(state is LoadingState){
                return LoadingWidget();
              }
              if(state is SuccessState){
                return SafeArea(
                  child: SmartRefresher(
                    controller: refreshController,
                    enablePullUp: false,
                    header: ClassicHeader(),
                    onRefresh: (){
                      BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(cancelToken: cancelToken));
                      Future.delayed(const Duration(seconds: 1),()=>refreshController.refreshCompleted(resetFooterState: true));
                    },
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(height: CoreStyle.setHeightPercentage(3, context),),
                                Text(mainEnumValues.reverse[state.data.list[widget.selectedDay].weather[0].main],style: GlobalTextStyle.largeLargeTextWhite,),
                                Text(descriptionValues.reverse[state.data.list[widget.selectedDay].weather[0].description].replaceAll(" ", "\n"),
                                  style: GlobalTextStyle.largeLargeTextWhite,),
                              ],
                            ),
                          ),
                          Center(
                            child: Image.network("http://openweathermap.org/img/wn/${state.data.list[0].weather[0].icon}@2x.png",
                              scale: 0.25,
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: CoreStyle.setWidthPercentage(20, context),
                              width: CoreStyle.setWidthPercentage(20, context),
                              decoration: BoxDecoration(
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 15.0,
                                    offset: const Offset(3.0, 3.0),
                                  )
                                ],
                                borderRadius: const BorderRadius.all(Radius.circular(180.0)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(state.data.city.name,style: GlobalTextStyle.largeLargeTextWhite,),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(state.data.list[widget.selectedDay].main.temp,style: GlobalTextStyle.biggestTextWhite,),
                                      Text("O",style: GlobalTextStyle.largeLargeTextWhite,)
                                    ],
                                  ),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      WindHumidityWidget(value: state.data.list[widget.selectedDay].wind.speed,),
                                      const  SizedBox(width: 12.0,),
                                      WindHumidityWidget(value: state.data.list[widget.selectedDay].main.humidity,),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(width: 1,),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              if(state is FailureState){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        ERROR_MESSAGE,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      RaisedButton(
                        onPressed: state.callback,
                        child: Text(
                          RETRY,
                          style: GlobalTextStyle.middleTextWhite,
                        ),
                        color: Theme.of(context).accentColor,
                      ),
                    ],
                  ),
                );
              }
              else return Container();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    cancelToken.cancel();
  }
}
