import 'package:dio/dio.dart';

class DioClient {
  DioClient({Dio? dio})
    : dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 12),
              receiveTimeout: const Duration(seconds: 12),
              sendTimeout: const Duration(seconds: 12),
              responseType: ResponseType.json,
            ),
          );

  final Dio dio;
}
