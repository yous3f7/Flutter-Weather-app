import 'package:flutter/material.dart';
import 'package:weather/core/constants.dart';
import 'package:weather/core/global/CoreStyle.dart';

class WindHumidityWidget extends StatelessWidget {
  final String value;

  const WindHumidityWidget({Key key, this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.white,
            blurRadius: 6.0,
            offset: Offset(3.0, 3.0),
          )
        ],
      ),
      padding: const EdgeInsets.all(8),
      height: CoreStyle.setWidthPercentage(18, context),
      width: CoreStyle.setWidthPercentage(20, context),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(WIND,style: GlobalTextStyle.normalText,),
          Text(value,style: GlobalTextStyle.normalText,),
        ],
      ),
    );
  }
}
