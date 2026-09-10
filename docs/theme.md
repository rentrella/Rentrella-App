# 테마 시스템

값 하드코딩 금지. 모든 색상·크기·간격은 아래 상수 클래스 사용.

## 클래스 목록

| 클래스 | 파일 | 용도 |
|--------|------|------|
| `AppColors` | `theme/color/app_colors.dart` | 색상 |
| `AppTextStyle` | `theme/font/app_text_style.dart` | 텍스트 스타일 |
| `AppShadow` | `theme/shadow/app_shadow.dart` | 그림자 |
| `AppSpacing` | `theme/constants/app_spacing.dart` | 여백 (s1~s60) |
| `AppSize` | `theme/constants/app_size.dart` | 고정 크기 (s2~s88) |
| `AppRadius` | `theme/constants/app_radius.dart` | 모서리 반경 (r4~r60) |
| `AppIcon` | `theme/icon/app_icon.dart` | SVG 아이콘 enum |

## AppColors

```
Neutral: black, mainText, subD_1~4, subL_1~5, white, bg_1
Blue:    primary(#5DAEEA), pD_1~4, pL_1~5
Green:   g_1~3
Red:     r_1~3, o_1
```

주요 용도:
- 배경: `bg_1` (#EEF2F7)
- 기본 텍스트: `mainText` (#111827)
- 보조 텍스트: `subD_4`, `subL_1`
- 테두리 기본: `subL_3`
- 포커스/강조: `primary`
- 에러: `r_1`, `r_2`

## AppTextStyle

| 스타일 | 크기 | 굵기 | 용도 |
|--------|------|------|------|
| `title1` | 24px | bold | 화면 제목 |
| `title2` | 22px | bold | 섹션 제목 |
| `body3` | 15px | w500 | 본문 강조 |
| `body4` | 15px | w400 | 본문 |
| `caption1` | 14px | bold | |
| `content2` | 11px | w500 | 입력 필드 텍스트·힌트, 라벨 |
| `button1` | 15px | bold | 주요 버튼 |
| `button2` | 12px | bold | 보조 버튼 |

## AppShadow

| 상수 | offset | blur | 용도 |
|------|--------|------|------|
| `card` | (0, 1) | 4 | 카드, 버튼 |
| `field` | (0, 3) | 4 | 텍스트 필드 |

## AppIcon 사용법

```dart
AppIcon.email.icon(size: AppSize.s12)
AppIcon.lock.icon(size: AppSize.s16, color: AppColors.primary)
```

아이콘 목록: `email`, `lock`, `key`, `visibility`, `visibilityOff`, `person`, `arrowBack`, `close`, `bell` 등
전체 목록: `theme/icon/app_icon.dart` 참고
