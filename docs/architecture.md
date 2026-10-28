# 프로젝트 구조

## 디렉토리

```
lib/
├── core/
│   ├── enum/            # 공통 enum (FormStatus, LoadStatus 등)
│   ├── network/         # Dio 클라이언트, 토큰 저장소, 인증 인터셉터, ApiException
│   ├── routes/          # GoRouter 라우팅
│   ├── theme/           # 디자인 시스템 상수
│   └── widgets/         # 전역 공통 위젯
├── feature/
│   ├── auth/
│   │   ├── core/        # auth 내부 공통 (enum, widget)
│   │   ├── login/
│   │   ├── signup/
│   │   └── password_change/
│   ├── home/
│   ├── my_page/     # StatefulShellRoute 탭 (계정·설정 / 알림 내역)
│   └── splash/
└── main.dart
```

각 화면 경로: `feature/<도메인>/<기능>/presentation/<기능>_screen.dart`

## 라우팅

패키지: `go_router` — `AppRoutes` enum으로 모든 라우트 관리 (`core/routes/app_route.dart`)

```dart
enum AppRoutes {
  splash,                              // /splash
  auth, main,                          // shell
  login, signup, passwordChange,       // /auth/*
  home,                                // /main/*
  accountAndSetting, notificationHistory, // /main/* (마이페이지 탭)
}
```

화면 이동: `context.goNamed(AppRoutes.xxx.name)`
초기 경로: `/splash` → 2초 후 `/auth/login`

## Feature 레이어 패턴

상태관리: `flutter_bloc` (BLoC) + `equatable`.

```
feature/<도메인>/
├── data/
│   ├── models/          # 서버 응답 모델 (Equatable)
│   └── repositories/    # <이름>_repository.dart (interface) + api_<이름>_repository.dart + mock_<이름>_repository.dart
├── bloc/                # <이름>_bloc.dart + part '<이름>_event.dart' / '<이름>_state.dart'
└── presentation/
```

auth는 기능별로 `feature/auth/<기능>/bloc/`, 리포지토리는 `feature/auth/core/data/`에 둔다.

### 리포지토리

- 인터페이스(`abstract interface class`)와 `Api`·`Mock` 구현체를 분리한다. 목 데이터는 Mock 구현체 안에만 둔다.
- `main.dart`의 `MultiRepositoryProvider`에서 주입한다. 기본은 Api 구현체, `--dart-define=USE_MOCK=true`(또는 `App(useMock: true)`, 테스트)면 Mock 구현체를 쓴다.
- 실패는 `ApiException`(`core/network/api_exception.dart`)으로 던진다. Api 구현체는 요청을 `guardApi()`로 감싸 `DioException` → 서버 에러 바디의 `message`로 바꾸고, BLoC은 `on ApiException catch (e)`로 받아 `e.message`를 에러 상태(배너·스낵바)에 넣는다. (`AuthException`은 `ApiException`의 하위 타입)

| 리포지토리 | 위치 | 사용 BLoC |
|-----------|------|-----------|
| `AuthRepository` | `auth/core/data/repositories/` | `LoginBloc`, `SignupBloc`, `PasswordChangeBloc` (+ 로그아웃) |
| `UmbrellaRepository`, `WeatherRepository` | `home/data/repositories/` | `HomeBloc` |
| `NotificationRepository` | `my_page/data/repositories/` | `NotificationHistoryBloc`, `NotificationSettingBloc` |

| 리포지토리 | Api 구현체 | 비고 |
|-----------|-----------|------|
| `AuthRepository` | `ApiAuthRepository` | `/auth/*`. 인증코드 확인 API가 없어 `verifyCode`는 형식만 확인, 실제 검증은 재설정 요청 시 서버가 한다 |
| `UmbrellaRepository` | `ApiUmbrellaRepository` | `GET /umbrella`(개수), `GET /umbrella/me`, `POST /umbrella/Rental`·`/return`. 칸 목록 API가 없어 목록은 Mock 칸 + 내 대여만 반영 (TODO) |
| `WeatherRepository`, `NotificationRepository` | — | 서버 미구현 → Mock 유지 |

## 서버 연동 (`core/network/`)

| 파일 | 역할 |
|------|------|
| `api_config.dart` | `API_BASE_URL`(기본 `http://10.0.2.2:8888`, 안드로이드 에뮬레이터), `USE_MOCK` — `--dart-define`으로 주입 |
| `api_client.dart` | `createApiClient()` — Dio 생성 + `AuthInterceptor` 장착 |
| `auth_interceptor.dart` | `/auth/*` 외 요청에 `Authorization: Bearer` 부착. 401이면 `/auth/reissue`로 한 번 재발급 후 재시도, 실패하면 토큰 삭제 + 로그인 화면 이동 |
| `token_storage.dart` | `SecureTokenStorage`(flutter_secure_storage). 로그인 유지 체크 시에만 기기에 저장, 아니면 메모리. 스플래시는 저장된 토큰이 있으면 홈으로 이동 |
| `api_exception.dart` | `ApiException`, `guardApi()` |

```bash
flutter run --dart-define=API_BASE_URL=http://192.168.0.10:8888   # 실기기
flutter run --dart-define=USE_MOCK=true                            # 서버 없이
```

Api 구현체 테스트는 `test/helpers/fake_http_adapter.dart`(요청 기록 + 응답 등록)로 경로·바디·응답 파싱을 검증한다.

### 화면과 BLoC

- 화면(`StatelessWidget`)이 `BlocProvider`로 BLoC을 만들고(`context.read()`로 리포지토리 주입), 내부 `_XxxView`가 `BlocBuilder`/`BlocConsumer`로 그린다.
- 폼 입력은 `TextEditingController` 대신 `onChanged` → 이벤트로 BLoC state에 보관한다. 제출 결과(`FormStatus.success`)에 따른 화면 이동은 `BlocConsumer.listener`에서 처리한다.
- 순수 UI 상태(비밀번호 보기 토글, 약관 펼침, 스크롤 그림자, 애니메이션)는 위젯 로컬 상태로 둔다.
- 다이얼로그는 별도 route라 BLoC을 직접 찾지 못하므로 값과 콜백(`onChanged` 등)으로 전달한다.

auth 내부 공통은 `feature/auth/core/` 에 위치.
필드 우측 버튼(인증코드 발송·확인)은 `AuthActionButton`을 쓴다.
인증 화면(로그인·회원가입·비밀번호 변경)은 `AuthFormLayout`으로 공통 레이아웃(제목·폼·에러 배너·제출 버튼·하단 링크)을 구성하고, 화면은 필드와 검증만 가진다.

탭 페이지처럼 화면 일부를 채우는 페이지는 `presentation/pages/`, 화면 전용 위젯은 `presentation/widgets/`에 둔다.

## 구현된 화면

| 화면 | 라우트 | 파일 |
|------|--------|------|
| 스플래시 | `/splash` | `splash/presentation/screens/splash_screen.dart` |
| 로그인 | `/auth/login` | `auth/login/presentation/login_screen.dart` |
| 회원가입 | `/auth/signup` | `auth/signup/presentation/signup_screen.dart` |
| 비밀번호 변경 | `/auth/password_change` | `auth/password_change/presentation/password_change_screen.dart` |
| 홈 | `/main/home` | `home/presentation/screens/home_screen.dart` |
| 마이페이지 · 계정 정보 및 설정 | `/main/account_and_setting` | `my_page/presentation/pages/account_and_setting_page.dart` |
| 마이페이지 · 알림 내역 | `/main/notification_history` | `my_page/presentation/pages/notification_history_page.dart` |

마이페이지는 `MyPageRoute`(StatefulShellRoute.indexedStack)로 두 탭을 묶고, `MyPageScreen`이 공통 앱바·탭바를 그린다.
`MainRoute`(`/main`) 하위 라우트이므로 `path`는 `fullPath`가 아닌 상대 경로(`AppRoutes.xxx.path`)를 사용한다.
