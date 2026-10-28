import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';

/// 요청을 기록하고, 등록된 응답을 돌려주는 테스트용 어댑터
class FakeHttpAdapter implements HttpClientAdapter {
  final requests = <RequestOptions>[];
  final _handlers = <String, List<(int, Object?)>>{};

  /// `'POST /auth/login'`처럼 메서드+경로로 응답을 등록한다. 여러 번 등록하면 순서대로 소비한다.
  void on(String route, int status, [Object? body]) =>
      (_handlers[route] ??= []).add((status, body));

  /// 기록된 요청의 JSON 바디
  Map<String, dynamic> bodyOf(RequestOptions options) => options.data is String
      ? jsonDecode(options.data as String) as Map<String, dynamic>
      : options.data as Map<String, dynamic>;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add(options);
    final route = '${options.method} ${options.path}';
    final queue = _handlers[route];
    if (queue == null || queue.isEmpty) {
      throw StateError('등록되지 않은 요청: $route');
    }
    final (status, body) = queue.length > 1 ? queue.removeAt(0) : queue.first;

    return ResponseBody.fromString(
      body == null ? '' : jsonEncode(body),
      status,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

/// 서버 ApiErrorResponse 형식
Map<String, Object?> errorBody(int status, String message) => {
  'timestamp': '2026-10-28T00:00:00',
  'status': status,
  'error': 'Error',
  'message': message,
};
