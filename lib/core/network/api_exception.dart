import 'package:dio/dio.dart';

/// 서버 통신 실패. [message]는 화면(에러 배너 등)에 그대로 보여준다.
class ApiException implements Exception {
  const ApiException(this.message, {this.statusCode});

  /// 서버 에러 바디(`{timestamp, status, error, message}`)의 message를 우선 사용한다.
  factory ApiException.fromDio(DioException e) {
    final data = e.response?.data;
    final serverMessage = data is Map ? data['message'] : null;

    return ApiException(
      serverMessage is String && serverMessage.isNotEmpty
          ? serverMessage
          : switch (e.type) {
              .connectionTimeout ||
              .sendTimeout ||
              .receiveTimeout => '서버 응답이 지연되고 있어요. 잠시 후 다시 시도해 주세요.',
              .connectionError => '서버에 연결할 수 없어요. 네트워크를 확인해 주세요.',
              _ => '요청을 처리하지 못했어요. 잠시 후 다시 시도해 주세요.',
            },
      statusCode: e.response?.statusCode,
    );
  }

  final String message;
  final int? statusCode;

  @override
  String toString() => 'ApiException($statusCode): $message';
}

/// [DioException]을 [ApiException]으로 바꿔 던진다.
Future<T> guardApi<T>(Future<T> Function() request) async {
  try {
    return await request();
  } on DioException catch (e) {
    throw ApiException.fromDio(e);
  }
}
