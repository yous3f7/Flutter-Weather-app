import 'dart:convert';
import 'dart:io';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'api_url.dart';
import 'http_method.dart';
import '../errors/base_error.dart';
import '../errors/bad_request_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';


class ApiProvider {
  // Singleton handling.
  static ApiProvider _instance;
  static ApiProvider getInstance(){
    if (_instance != null) return _instance;
    _instance = ApiProvider();
    return _instance;
  }

  final option =BaseOptions(
    baseUrl: API_BASE,
    connectTimeout: 20000,
  );
  Dio _dio;

  Future<Either<BaseError, TResponse>> sendRequest<TResponse>({
    @required HttpMethod method,
    @required String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
  }) async {
    assert(method != null);
    assert(url != null);
    _dio = Dio(option);
    _dio.interceptors.add(
        DioCacheManager(
            CacheConfig(
              baseUrl: API_BASE,
              defaultMaxAge: const Duration(days: 1),
            ),
        ).interceptor);
    try {
      print('[$method: $url]');

      // Get the response from the server
      Response response = await _dio.get(
            url,
            queryParameters: queryParameters,
            options: buildCacheOptions(
                const Duration(days: 1),
                options: Options(headers: headers),
                forceRefresh: true,
                maxStale:const Duration(days: 1),
            ),
            cancelToken: cancelToken,
          );

      // Get the decoded json
      if (response.data is String)
        return Right(json.decode(response.data) as TResponse);
      else{
        return Right(response.data as TResponse);
      }
    }

    // Handling errors
    on DioError catch (e) {
      return Left(_handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Left(SocketError());
    }
  }

  static BaseError _handleDioError(DioError error) {
    if (error.type == DioErrorType.DEFAULT ||
        error.type == DioErrorType.RESPONSE) {
      if (error is SocketException) return SocketError();
      if (error.type == DioErrorType.RESPONSE) {
        switch (error.response.statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();
          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.SEND_TIMEOUT ||
        error.type == DioErrorType.RECEIVE_TIMEOUT) {
      return TimeoutError();
    } else if (error.type == DioErrorType.CANCEL) {
      return CancelError();
    } else
      return UnknownError();
  }
}
