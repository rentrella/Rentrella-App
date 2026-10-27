# 공통 위젯

위치: `lib/core/widgets/`

---

## BaseScaffold

모든 화면의 기본 Scaffold 래퍼.

```dart
BaseScaffold(
  appBar: AppBanner(),   // 선택
  body: ...,
  bottomNavigationBar: ...,  // 선택
)
```

- `backgroundColor` 기본값: `AppColors.bg_1`
- `resizeToAvoidBottomInset: false` 고정

---

## AppTextField

Figma 스펙 기반 입력 필드.

```dart
AppTextField(
  label: '이메일',
  hint: '이메일을 입력해 주세요.',
  prefixIcon: AppIcon.email,
  onChanged: (v) => bloc.add(LoginEmailChanged(v)), // BLoC 화면은 onChanged 사용
  error: state.emailError, // null이면 정상 상태
  suffix: IconButton(...),   // 필드 내부 우측 버튼
  action: _ActionButton(...), // 필드 외부 우측 버튼
  hide: true,           // 비밀번호 숨김
)
```

| prop | 설명 |
|------|------|
| `suffix` | Stack + Positioned 처리 → 컨테이너 높이 고정, 터치 영역 보존 |
| `action` | Row 외부 배치 (예: "인증코드 발송") |
| `error` | non-null 시 에러 border + 하단 메시지 표시 |
| `hide` | `obscureText` 제어 |
| `onChanged` | 입력값 변경 콜백. BLoC 화면에서는 `controller` 대신 이벤트로 전달 |

---

## SubmitButton

화면 하단 주요 제출 버튼.

```dart
SubmitButton(title: '로그인 하기', onPressed: _validate)
SubmitButton(title: '확인', onPressed: null)  // 비활성
```

- `onPressed != null` → 파란 그라디언트 활성
- `onPressed == null` → 회색 비활성

---

## SubElevatedButton

회색(`subL_4`) 배경 보조 버튼. 다이얼로그의 취소·돌아가기, 선택지 버튼에 사용.

```dart
SubElevatedButton(label: '취소', onPressed: () {})
SubElevatedButton(label: '알림 허용', onPressed: () {}, trailing: radioMark)
```

---

## AppBaseButton

`InkWell` 기반 최소 버튼 래퍼. 커스텀 버튼 구현 시 기반으로 사용.

```dart
AppBaseButton(
  onPressed: () {},
  radius: AppRadius.r8,
  child: Padding(...),
)
```

---

## AppTextButton

인라인 텍스트 링크 버튼.

```dart
AppTextButton(label: '로그인으로 돌아가기', color: AppColors.pD_3, onPressed: () {})
```

---

## AppBanner

`PreferredSizeWidget`. 화면 상단 앱 로고 배너.

```dart
BaseScaffold(appBar: AppBanner(), body: ...)
```

---

## AppDialog

로고 · 제목 · 닫기 버튼 헤더를 가진 다이얼로그 틀. `AppDialog.show`로 띄우면 Figma 기준 배경 딤(`pMulk_1` 40%)이 적용된다.

```dart
AppDialog.show(context, AppDialog(
  title: Text('우산 대여하기', style: AppTextStyle.title1),
  children: [...],
));
```

- `padding` 기본 24, `spacing` 기본 18
- 구현체: `InquiryDialog`(core, 문의하기 — 홈·마이페이지 공용), `BorrowDialog`(home, 우산 대여 확인), `NotificationSettingDialog`·`LogoutDialog`(my_page)

---

## AppErrorBanner

하단 버튼 영역 바로 위에 붙는 에러 배너 (`Error | 메시지`). `message`가 null이면 접힌다.

```dart
AppErrorBanner(message: _bannerErr),
Material(child: SubmitButton(...)),
```

로그인·비밀번호 변경 화면에서 `AuthErrors.banner(email:, password:)`로 메시지를 정한다.

---

## AppChip / AppIconBox

상태 라벨 칩과 색 배경 아이콘 박스. `UmbrellaStatusChip`·`UmbrellaStatusIcon`, `NotificationCard`가 내부적으로 사용한다.

```dart
AppChip(label: '연체됨', background: AppColors.r_3, color: AppColors.r_2)
AppIconBox(icon: .umbrellaFold, background: AppColors.primary, size: AppSize.s12)
```

---

## auth 전용: AuthFormLayout / PasswordTextField

위치: `feature/auth/core/widgets/`

- `AuthFormLayout` — 인증 화면 공통 틀. `title`, `subtitle`, `fields`, `submitLabel`, `onSubmit`, `footerText`·`footerAction`·`onFooterAction`, `bannerError`
- `PasswordTextField` — 보기/숨기기 토글을 내부 상태로 가진 비밀번호 필드 (`onChanged` 지원)

---

## 위젯 추가 기준

- 2개 이상의 화면에서 동일한 UI가 반복되면 `core/widgets/`로 추출
- 특정 feature에서만 쓰이는 위젯은 `feature/<도메인>/core/widgets/` 또는 `presentation/` 내부에 private 클래스로 유지
