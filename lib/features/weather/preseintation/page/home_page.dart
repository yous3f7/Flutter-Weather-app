import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/core/global/CoreStyle.dart';
import 'package:weather/features/weather/preseintation/bloc/weather_bloc.dart';
import 'package:weather/features/weather/preseintation/bloc/weather_event.dart';
import 'package:weather/features/weather/preseintation/widget/build_card_widget.dart';

import 'weather_page.dart';

class HomePage extends StatefulWidget {
  final DateTime dateNow  = DateTime.now();
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cancelToken = CancelToken();
  List<DateTime> listThreeDateTime ;

  AppBar appBar = AppBar(title: Text(TITLE_APP_NAME),centerTitle: true,);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: listThreeDateTime.length,
          itemBuilder: (ctx,i){
            return InkWell(
              onTap: (){
                Navigator.of(context).pushNamed(WeatherPage.routeName,arguments: i);
              },
              child: BuildCardWidget(
                dateName: _formatDate(listThreeDateTime[i]),
                appBarSize: appBar.preferredSize.height,
                placeHolder: i==0?IMG_PLACE_HOLDER0:i==2?IMG_PLACE_HOLDER1:IMG_PLACE_HOLDER2,
              ),
            );
          },
        ),
      )
    );
  }

  @override
  void initState() {
    super.initState();
    listThreeDateTime = List<DateTime>();
    for(int i=0;i<3;i++){
      listThreeDateTime.add(DateTime.now().add(Duration(days: i)));
    }
    BlocProvider.of<WeatherBloc>(context).add(FetchWeatherEvent(cancelToken: cancelToken));
  }

  @override
  void dispose() {
    super.dispose();
    BlocProvider.of<WeatherBloc>(context).close();
    cancelToken.cancel();
  }

  String _formatDate(DateTime dateTime){
    return MaterialLocalizations.of(context).formatFullDate(dateTime);
  }

}
