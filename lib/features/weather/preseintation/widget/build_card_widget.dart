import 'package:flutter/material.dart';
import 'package:weather/core/global/CoreStyle.dart';

class BuildCardWidget extends StatelessWidget {
  @required final appBarSize;
  @required final String dateName;
  @required final String placeHolder;

  const BuildCardWidget({Key key, this.appBarSize, this.dateName, this.placeHolder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: CoreStyle.setHeightPercentage(37.5, context)-appBarSize,
      child: Stack(
        children: <Widget>[
          Container(
            decoration:  BoxDecoration(
              image:  DecorationImage(
                  image:  AssetImage(placeHolder),
                  colorFilter:  ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.darken,
                  ),
                  fit: BoxFit.cover
              ),
            ),
            child: SizedBox.expand(
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      dateName,
                      style: GlobalTextStyle.largeLargeTextWhite,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
