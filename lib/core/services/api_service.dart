
import 'package:dio/dio.dart';
import 'package:user_app_for_sokrio/core/app_config/ulrs.dart';

class ApiService {

  ApiService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppUrls.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.next(options);
        },
        onError: (error, handler) {
          return handler.next(error);
        },
      ),
    );
  }

  static final ApiService _instance = ApiService._internal();

  static ApiService get instance => _instance;

  late final Dio _dio;

  Future<Response> getRequest(String endpoint, {Map<String, dynamic>? params}) async {
    try {
      final response = await _dio.get(endpoint, queryParameters: params);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }


  Future<Response> postRequest(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }


  String _handleError(DioException error) {
    if (error.response != null && error.response?.data != null) {
      return error.response?.data['error'] ?? 'Unknown error occurred';
    } else if (error.type == DioExceptionType.connectionTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    }
    else if (error.type == DioExceptionType.connectionError) {
      return 'Connection timeout. Please check your internet connection.';
    }else if (error.type == DioExceptionType.receiveTimeout) {
      return 'Server took too long to respond.';
    } else if (error.type == DioExceptionType.badResponse) {
      return 'Bad response from server.';
    } else {
      return 'Unexpected error occurred.';
    }
  }
}