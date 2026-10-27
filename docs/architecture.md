# 프로젝트 구조

## 디렉토리

```
lib/
├── core/
│   ├── enum/            # 공통 enum (FormStatus, LoadStatus 등)
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
│   └── repositories/    # <이름>_repository.dart (interface) + mock_<이름>_repository.dart
├── bloc/                # <이름>_bloc.dart + part '<이름>_event.dart' / '<이름>_state.dart'
└── presentation/
```

auth는 기능별로 `feature/auth/<기능>/bloc/`, 리포지토리는 `feature/auth/core/data/`에 둔다.

### 리포지토리

- 인터페이스(`abstract interface class`)와 `Mock` 구현체를 분리한다. 목 데이터는 Mock 구현체 안에만 둔다.
- `main.dart`의 `MultiRepositoryProvider`에서 주입한다. 서버 연동 시 이 곳의 Mock 구현체만 실제 구현체로 교체한다.

| 리포지토리 | 위치 | 사용 BLoC |
|-----------|------|-----------|
| `AuthRepository` | `auth/core/data/repositories/` | `LoginBloc`, `SignupBloc`, `PasswordChangeBloc` (+ 로그아웃) |
| `UmbrellaRepository`, `WeatherRepository` | `home/data/repositories/` | `HomeBloc` |
| `NotificationRepository` | `my_page/data/repositories/` | `NotificationHistoryBloc`, `NotificationSettingBloc` |

### 화면과 BLoC

- 화면(`StatelessWidget`)이 `BlocProvider`로 BLoC을 만들고(`context.read()`로 리포지토리 주입), 내부 `_XxxView`가 `BlocBuilder`/`BlocConsumer`로 그린다.
- 폼 입력은 `TextEditingController` 대신 `onChanged` → 이벤트로 BLoC state에 보관한다. 제출 결과(`FormStatus.success`)에 따른 화면 이동은 `BlocConsumer.listener`에서 처리한다.
- 순수 UI 상태(비밀번호 보기 토글, 약관 펼침, 스크롤 그림자, 애니메이션)는 위젯 로컬 상태로 둔다.
- 다이얼로그는 별도 route라 BLoC을 직접 찾지 못하므로 값과 콜백(`onChanged` 등)으로 전달한다.

auth 내부 공통은 `feature/auth/core/` 에 위치.
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
