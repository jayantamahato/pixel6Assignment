import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../exports.dart';

class ApiService {
  final Dio _dio = Dio();
  ApiService() {
    //setting the base url
    String baseUrl = AppConfig.getBaseUrl();
    _dio.options.baseUrl = baseUrl;
    //setting logger
    _dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
    ));
  }
  Dio get request => _dio;
}
