import 'package:dio/dio.dart';

class ContentTypeInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    options.contentType = 'application/json';
    handler.next(options);
  }
}
