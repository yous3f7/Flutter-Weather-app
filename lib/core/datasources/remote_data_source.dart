import 'package:flutter/foundation.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../errors/base_error.dart';
import '../http/api_provider.dart';
import '../http/http_method.dart';

abstract class RemoteDataSource {

  Future<Either<BaseError, Data>> request<Data, Response>({
    @required Response Function(dynamic) converter,
    @required HttpMethod method,
    @required String url,
    Map<String, dynamic> queryParameters,
    Map<String, dynamic> data,
    bool withAuthentication = false,
    CancelToken cancelToken,
  }) async {
    assert(converter != null);
    assert(method != null);
    assert(url != null);

    // Specify the headers.
    final Map<String, String> headers = {};

    // Send the request.
    final response = await ApiProvider.getInstance().sendRequest<Response>(
      method: method,
      url: url,
      headers: headers,
      queryParameters: queryParameters ?? {},
      data: data,
      cancelToken: cancelToken,
    );
    // convert jsonResponse to model and return it
    var responseModel;

    if (response.isLeft()) {
      return Left((response as Left<BaseError, Response>).value);
    } else if (response.isRight()) {
      try {
        /// convert response json to model
        responseModel = converter((response as Right<BaseError, Response>).value);
        print(responseModel.runtimeType.toString());
        print(responseModel);
      } catch (e) {
        print(e);
      }
      return Right(responseModel);
    }
    else return null;
  }
}
