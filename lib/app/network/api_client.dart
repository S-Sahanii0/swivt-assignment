import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:swivt_assignment/app/exceptions/app_exceptions.dart';

import '../../utils/app_logger.dart';

class ApiClient {
  //Doing this will use same instance all over the app
  factory ApiClient() {
    return _instance;
  }

  ApiClient._private() {
    _dio = Dio();
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }

  late Dio _dio;
  static final ApiClient _instance = ApiClient._private();

  Future<Map<String, dynamic>> get(String url) async {
    Map<String, dynamic> responseJson;
    try {
      final response = await _dio.get<dynamic>(url);
      responseJson = _returnMapResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  String _returnListResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
      case 204:
        final responseJson = jsonEncode(response.data);
        log(responseJson);
        return responseJson;
      case 400:
        throw BadRequestException(response.data.toString());
      case 401:
      case 404:
        throw UnauthorisedException(response.data.toString());
      case 500:
      default:
        throw FetchDataException(
          'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
        );
    }
  }
}

Map<String, dynamic> _returnMapResponse(Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
    case 204:
      final dynamic responseJson = response.data;
      AppLogger.info(responseJson.toString());
      return responseJson as Map<String, dynamic>;
    case 302:
      return <String, dynamic>{};

    case 400:
      throw BadRequestException(response.data.toString());
    case 401:
    case 404:
      throw UnauthorisedException(response.data.toString());
    case 500:
    default:
      throw FetchDataException(
        'Error occured while Communication with Server with StatusCode : ${response.statusCode}',
      );
  }
}
