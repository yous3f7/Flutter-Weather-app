import 'package:dio/dio.dart';

abstract class BaseParams {
  final CancelToken cancelToken;

  BaseParams({this.cancelToken});
}
