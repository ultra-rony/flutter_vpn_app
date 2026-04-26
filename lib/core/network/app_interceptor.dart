import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class AppInterceptor extends Interceptor {
  final Logger _logger;

  AppInterceptor(this._logger);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';

    _logger.i('➡️ [${options.method}] ${options.uri}');
    _logger.i('Headers: ${options.headers}');

    if (options.queryParameters.isNotEmpty) {
      _logger.i('Query: ${options.queryParameters}');
    }

    if (options.data != null) {
      _logger.i('Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logger.i('✅ [${response.statusCode}] ${response.requestOptions.uri}');
    _logger.i('Response body: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final request = err.requestOptions;
    final response = err.response;

    _logger.e('⛔ Raw error: ${err.error}');
    _logger.e('⛔ Stack: ${err.stackTrace}');

    _logger.e('⛔ ERROR TYPE: ${err.type}');
    _logger.e('⛔ [${request.method}] ${request.uri}');
    _logger.e('⛔ Message: ${err.message}');

    if (response != null) {
      _logger.e('⛔ Status: ${response.statusCode}');
      _logger.e('⛔ Response headers: ${response.headers}');
      _logger.e('⛔ Response body: ${response.data}');
    } else {
      _logger.e('⛔ No response from server');
    }

    handler.next(err);
  }
}
