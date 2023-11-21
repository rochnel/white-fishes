import 'package:dio/dio.dart';
import '../strings/app_strings.dart';

class DioProvider {
  final Dio _dio;

  // constructor
  DioProvider() : _dio = Dio() {
    _dio.options.baseUrl = AppStrings.baseUrl;
    _dio.options.responseType = ResponseType.json;
  }

  // getter
  Dio get client => _dio;
}
