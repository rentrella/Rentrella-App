import 'package:equatable/equatable.dart';
import 'package:rentrella/core/enum/umbrella_status.dart';

class UmbrellaModel extends Equatable {
  const UmbrellaModel({required this.id, required this.status, this.user});

  final int id;
  final UmbrellaStatus status;

  /// 대여 중인 사용자 이름 (다른 유저가 대여·연체 중일 때)
  final String? user;

  UmbrellaModel copyWith({UmbrellaStatus? status, String? user}) =>
      UmbrellaModel(id: id, status: status ?? this.status, user: user);

  @override
  List<Object?> get props => [id, status, user];
}
