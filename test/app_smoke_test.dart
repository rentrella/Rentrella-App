import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/main.dart';

void main() {
  testWidgets('스플래시 → 로그인 → 홈까지 리포지토리·BLoC이 연결된다', (tester) async {
    tester.view.physicalSize = const Size(402, 872);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const App(useMock: true));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('로그인 하기'), findsOneWidget);

    // 잘못된 입력 → 에러 배너
    await tester.tap(find.text('로그인 하기'));
    await tester.pumpAndSettle();
    expect(find.text('이메일이 올바르지 않습니다.'), findsOneWidget);

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 's12345@gsm.hs.kr');
    await tester.enterText(fields.at(1), 'abc12345');
    await tester.tap(find.text('로그인 하기'));
    // 홈 날씨 배너는 반복 애니메이션이라 settle 대신 고정 시간만큼 진행
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('우산 목록'), findsOneWidget);
    expect(find.text('총 7개 중 1개 가능'), findsOneWidget);
  });
}
