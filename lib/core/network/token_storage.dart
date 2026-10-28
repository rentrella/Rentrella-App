import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// 서버 TokenResponse (`{tokenType, accessToken, refreshToken, expiresIn}`)
class AuthTokens extends Equatable {
  const AuthTokens({required this.accessToken, required this.refreshToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json) => AuthTokens(
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );

  final String accessToken;
  final String refreshToken;

  @override
  List<Object?> get props => [accessToken, refreshToken];
}

abstract interface class TokenStorage {
  Future<AuthTokens?> read();

  /// [persist]가 false면 앱 종료 시 사라진다(로그인 유지 해제). null이면 이전 설정 유지.
  Future<void> save(AuthTokens tokens, {bool? persist});

  Future<void> clear();
}

/// 메모리에 캐시하고, 로그인 유지 시에만 기기 보안 저장소에 기록한다.
class SecureTokenStorage implements TokenStorage {
  SecureTokenStorage([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  static const _accessKey = 'access_token';
  static const _refreshKey = 'refresh_token';

  final FlutterSecureStorage _storage;
  AuthTokens? _tokens;
  bool _persist = true;
  bool _loaded = false;

  @override
  Future<AuthTokens?> read() async {
    if (_tokens != null || _loaded) return _tokens;
    _loaded = true;

    final (access, refresh) = (
      await _storage.read(key: _accessKey),
      await _storage.read(key: _refreshKey),
    );
    if (access != null && refresh != null) {
      _tokens = AuthTokens(accessToken: access, refreshToken: refresh);
    }
    return _tokens;
  }

  @override
  Future<void> save(AuthTokens tokens, {bool? persist}) async {
    _tokens = tokens;
    _loaded = true;
    _persist = persist ?? _persist;

    if (_persist) {
      await _storage.write(key: _accessKey, value: tokens.accessToken);
      await _storage.write(key: _refreshKey, value: tokens.refreshToken);
    } else {
      await _deleteStored();
    }
  }

  @override
  Future<void> clear() async {
    _tokens = null;
    _loaded = true;
    await _deleteStored();
  }

  Future<void> _deleteStored() async {
    await _storage.delete(key: _accessKey);
    await _storage.delete(key: _refreshKey);
  }
}

/// 테스트용 메모리 저장소
class MemoryTokenStorage implements TokenStorage {
  MemoryTokenStorage([this._tokens]);

  AuthTokens? _tokens;

  @override
  Future<AuthTokens?> read() async => _tokens;

  @override
  Future<void> save(AuthTokens tokens, {bool? persist}) async =>
      _tokens = tokens;

  @override
  Future<void> clear() async => _tokens = null;
}
