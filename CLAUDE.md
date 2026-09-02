# Rentrella App — Claude Instructions

## Git 컨벤션

### 커밋 메시지

Conventional Commits 규칙을 따릅니다.

```
<type>(<scope>): <subject>

[optional body]
```

**type 목록:**

| type | 사용 시점 |
|------|----------|
| `feat` | 새 기능 추가 |
| `fix` | 버그 수정 |
| `refactor` | 기능 변경 없는 코드 개선 |
| `chore` | 패키지 업데이트, 빌드 설정 등 |
| `docs` | 문서 수정 |
| `style` | 포맷, 세미콜론 등 로직 무관한 변경 |
| `test` | 테스트 추가/수정 |

**scope** — 영향받는 feature 또는 layer (선택사항):

예: `auth`, `home`, `core`, `router`

**subject 규칙:**
- 한글 또는 영문 모두 허용
- 명령형으로 작성 (추가, 수정, 삭제 / add, fix, remove)
- 마침표 없이 끝냄

**예시:**
```
feat(auth): 로그인 화면 추가
fix(auth): 비밀번호 유효성 검사 오류 수정
refactor(core): BaseScaffold 공통 레이아웃 분리
chore: flutter_bloc 9.1.1로 업데이트
docs: README 프로젝트 구조 항목 추가
```

---

### 브랜치 네이밍

```
<type>/#<이슈번호>-<간단한-설명>
```

- 설명은 kebab-case, 소문자
- 이슈 번호는 GitHub Issues 기준

**예시:**
```
feature/#23-login-screen
feature/#31-home-dashboard
fix/#45-password-validation-bug
chore/#12-update-flutter-deps
refactor/#58-auth-bloc-separation
```

**type은 커밋 type과 동일:** `feature`, `fix`, `refactor`, `chore`, `docs`

---

### 기본 워크플로우

1. 이슈 생성 → 브랜치 생성 → 작업 → 커밋 → PR → main 머지
2. main 브랜치에 직접 push 금지
3. PR 머지 후 작업 브랜치 삭제
