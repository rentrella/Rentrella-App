# Rentrella App — 아키텍처 문서

> Claude가 코드 작업 전 반드시 읽고, 변경 발생 시 이 문서를 직접 업데이트한다.

---

## 디렉토리 구조

```
lib/
├── core/
│   ├── routes/          # 라우팅
│   ├── theme/           # 디자인 시스템
│   └── widgets/         # 공통 위젯
├── feature/
│   ├── auth/            # 인증 feature
│   │   ├── core/        # auth 내부 공통 (enum, widget)
│   │   ├── login/
│   │   ├── signup/
│   │   └── password_change/
│   └── home/            # 홈 feature
└── main.dart
```

각 화면은 `feature/<도메인>/<기능>/presentation/<기능>_screen.dart` 경로를 따른다.

---

## 라우팅

**패키지:** `go_router`

**구조:** `AppRoutes` enum에 모든 라우트 정의 (`lib/core/routes/app_route.dart`)

```dart
enum AppRoutes {
  auth, main,           // section (shell route)
  login, signup, passwordChange,  // auth 하위
  home,                 // main 하위
}
```

- `AuthRoute` → `/auth/{login|signup|password_change}`
- `MainRoute` → `/main/{home}`
- 초기 경로: `/auth/login`
- 화면 이동 시 `context.goNamed(AppRoutes.xxx.name)` 사용

---

## 테마 시스템

모든 값은 상수 클래스로 정의되어 있으며, 하드코딩 금지.

| 클래스 | 파일 | 용도 |
|--------|------|------|
| `AppColors` | `theme/color/app_colors.dart` | 색상 팔레트 |
| `AppTextStyle` | `theme/font/app_text_style.dart` | 텍스트 스타일 |
| `AppShadow` | `theme/shadow/app_shadow.dart` | 박스 섀도우 |
| `AppSpacing` | `theme/constants/app_spacing.dart` | 여백 (padding, gap) |
| `AppSize` | `theme/constants/app_size.dart` | 위젯 고정 크기 |
| `AppRadius` | `theme/constants/app_radius.dart` | 모서리 반경 |
| `AppIcon` | `theme/icon/app_icon.dart` | SVG 아이콘 enum |

### 주요 색상
- `AppColors.primary` — `#5DAEEA` (Blue)
- `AppColors.mainText` — `#111827`
- `AppColors.subL_1~5` — 밝은 중립색 계열
- `AppColors.bg_1` — `#EEF2F7` (기본 배경)
- `AppColors.white` — `#FFFFFF`

### 주요 텍스트 스타일
- `title1` — 24px bold (화면 제목)
- `body3/4` — 15px w500/w400 (본문)
- `content2` — 11px w500 height 1.5 (입력 필드 텍스트, 힌트)
- `button1` — 15px bold / `button2` — 12px bold

### AppIcon 사용법
```dart
AppIcon.email.icon(size: AppSize.s12)
AppIcon.lock.icon(size: AppSize.s16, color: AppColors.primary)
```

---

## 공통 위젯

### `BaseScaffold`
모든 화면의 기본 Scaffold 래퍼.
- `backgroundColor` 기본값: `AppColors.bg_1`
- `resizeToAvoidBottomInset: false` 고정

```dart
BaseScaffold(appBar: AppBanner(), body: ...)
```

### `AppTextField`
Figma 스펙 기반 텍스트 입력 필드.

| prop | 타입 | 설명 |
|------|------|------|
| `label` | `String?` | 필드 상단 라벨 |
| `hint` | `String?` | 힌트 텍스트 |
| `prefixIcon` | `AppIcon?` | 왼쪽 아이콘 (12×12) |
| `suffix` | `Widget?` | 오른쪽 내부 버튼 (Stack으로 높이 고정) |
| `action` | `Widget?` | 필드 오른쪽 외부 버튼 (`_ActionButton` 등) |
| `error` | `String?` | 에러 메시지 (null이면 에러 상태 아님) |
| `hide` | `bool?` | 텍스트 숨김 (비밀번호) |
| `controller` | `TextEditingController?` | 입력값 제어 |
| `focusNode` | `FocusNode?` | 외부 포커스 제어 |

- suffix는 `Stack + Positioned`로 처리 → 컨테이너 높이에 영향 없음
- action은 필드 Row 외부에 위치 (예: "인증코드 발송" 버튼)

### `AppBaseButton`
`InkWell` 기반 최소 버튼 래퍼. 직접 사용보다 다른 버튼 위젯의 기반으로 사용.

### `SubmitButton`
화면 하단 주요 제출 버튼.
- `onPressed: null` → 비활성 (회색)
- `onPressed: () {...}` → 활성 (파란 그라디언트)

### `AppTextButton`
인라인 텍스트 링크 버튼. `color` prop으로 색상 지정.

### `AppBanner`
`PreferredSizeWidget` 구현체. 화면 상단 앱 로고 배너.

---

## Feature 구조 패턴

현재 퍼블리싱 단계로 BLoC 없이 `StatefulWidget` + 로컬 상태로 구현.
추후 BLoC 도입 시 아래 구조로 확장 예정:

```
feature/<도메인>/<기능>/
├── presentation/
│   └── <기능>_screen.dart
├── bloc/               # 추후 추가
│   ├── <기능>_bloc.dart
│   ├── <기능>_event.dart
│   └── <기능>_state.dart
└── widgets/            # 화면 전용 위젯 (추후 분리)
```

auth feature 내부 공통 요소는 `feature/auth/core/`에 위치:
- `enum/security_level.dart` — 비밀번호 보안 수준
- `widgets/password_security_card.dart` — 비밀번호 강도 표시
- `widgets/custom_check_box_tile.dart` — 커스텀 체크박스

---

## 현재 구현된 화면

| 화면 | 경로 | 파일 |
|------|------|------|
| 로그인 | `/auth/login` | `auth/login/presentation/login_screen.dart` |
| 회원가입 | `/auth/signup` | `auth/signup/presentation/signup_screen.dart` |
| 비밀번호 변경 | `/auth/password_change` | `auth/password_change/presentation/password_change_screen.dart` |
| 홈 | `/main/home` | `home/presentation/home_screen.dart` (미구현) |
