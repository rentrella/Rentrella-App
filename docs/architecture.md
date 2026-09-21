# 프로젝트 구조

## 디렉토리

```
lib/
├── core/
│   ├── routes/          # GoRouter 라우팅
│   ├── theme/           # 디자인 시스템 상수
│   └── widgets/         # 전역 공통 위젯
├── feature/
│   ├── auth/
│   │   ├── core/        # auth 내부 공통 (enum, widget)
│   │   ├── login/
│   │   ├── signup/
│   │   └── password_change/
│   └── home/
└── main.dart
```

각 화면 경로: `feature/<도메인>/<기능>/presentation/<기능>_screen.dart`

## 라우팅

패키지: `go_router` — `AppRoutes` enum으로 모든 라우트 관리 (`core/routes/app_route.dart`)

```dart
enum AppRoutes {
  auth, main,                          // shell
  login, signup, passwordChange,       // /auth/*
  home,                                // /main/*
}
```

화면 이동: `context.goNamed(AppRoutes.xxx.name)`
초기 경로: `/auth/login`

## Feature 레이어 패턴

현재 퍼블리싱 단계 — BLoC 없이 `StatefulWidget` + 로컬 상태.
추후 BLoC 도입 시 확장 구조:

```
feature/<도메인>/<기능>/
├── presentation/<기능>_screen.dart
├── bloc/          # 추후
└── widgets/       # 화면 전용 위젯 (추후)
```

auth 내부 공통은 `feature/auth/core/` 에 위치.

## 구현된 화면

| 화면 | 라우트 | 파일 |
|------|--------|------|
| 로그인 | `/auth/login` | `auth/login/presentation/login_screen.dart` |
| 회원가입 | `/auth/signup` | `auth/signup/presentation/signup_screen.dart` |
| 비밀번호 변경 | `/auth/password_change` | `auth/password_change/presentation/password_change_screen.dart` |
| 홈 | `/main/home` | `home/presentation/home_screen.dart` (미구현) |
