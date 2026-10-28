import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:rentrella/main.dart';

void main() {
  testWidgets('로그인 폼: 엔터로 다음 칸 이동, 마지막 칸에서 제출', (tester) async {
    tester.view.physicalSize = const Size(402, 872);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const App(useMock: true));
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    final fields = find.byType(TextField);
    await tester.enterText(fields.at(0), 's12345@gsm.hs.kr');
    await tester.testTextInput.receiveAction(TextInputAction.next);
    await tester.pump();

    // 비밀번호 보기 버튼을 건너뛰고 비밀번호 칸으로 이동
    expect(tester.widget<TextField>(fields.at(1)).focusNode!.hasFocus, isTrue);

    await tester.enterText(fields.at(1), 'abc12345');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    // 홈 날씨 배너는 반복 애니메이션이라 settle 대신 고정 시간만큼 진행
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('우산 목록'), findsOneWidget);
  });
}
