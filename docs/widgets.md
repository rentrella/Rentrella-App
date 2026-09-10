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
  controller: _ctrl,
  error: _errMsg,       // null이면 정상 상태
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

## 위젯 추가 기준

- 2개 이상의 화면에서 동일한 UI가 반복되면 `core/widgets/`로 추출
- 특정 feature에서만 쓰이는 위젯은 `feature/<도메인>/core/widgets/` 또는 `presentation/` 내부에 private 클래스로 유지
