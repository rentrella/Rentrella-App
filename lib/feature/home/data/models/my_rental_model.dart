import 'package:equatable/equatable.dart';

/// 내 대여 현황 (`GET /umbrella/me` → `{hasRental, deviceId}`)
class MyRentalModel extends Equatable {
  const MyRentalModel({required this.hasRental, this.deviceId});

  factory MyRentalModel.fromJson(Map<String, dynamic> json) => MyRentalModel(
    hasRental: json['hasRental'] as bool,
    deviceId: (json['deviceId'] as num?)?.toInt(),
  );

  static const none = MyRentalModel(hasRental: false);

  final bool hasRental;

  /// 대여 중인 우산 꽂이(칸) id
  final int? deviceId;

  @override
  List<Object?> get props => [hasRental, deviceId];
}
