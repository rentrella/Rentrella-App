import 'package:rentrella/core/enum/umbrella_status.dart';

class UmbrellaViewModel {
  final int id;
  final String content; //TODO 서버에서 보내주는 지 의문
  final UmbrellaStatus status;
  final String? user;

  UmbrellaViewModel({
    required this.id,
    required this.content,
    required this.status,
    this.user,
  });
}
