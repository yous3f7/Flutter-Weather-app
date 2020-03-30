import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:weather/core/params/base_params.dart';

class WeatherParams extends BaseParams {
  final int id;
  final String appId;

  WeatherParams({
    @required this.id,
    this.appId,
    CancelToken cancelToken,
  }): super(cancelToken:cancelToken);

  Map<String, dynamic> toJson() => {
    "id": id == null ? null : id,
    "appid": appId == null ? "1dc795da2bf6c1cf205ef7dd9f1cb60b" : appId,
  };
}
