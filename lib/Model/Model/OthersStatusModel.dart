// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'OthersStatusModel.g.dart';

@JsonSerializable()
class OthersStatusModel {
  OthersStatusModel(
      {required this.displayName,
      this.lastSeenAt,
      required this.avatarImage,
      required this.isGroup,
      required this.precense});
  final String displayName;
  final DateTime? lastSeenAt;
  final String avatarImage;
  final bool isGroup;
  final String precense;

  factory OthersStatusModel.fromJson(Map<String, dynamic> json) =>
      _$OthersStatusModelFromJson(json);

  Map<String, dynamic> toJson() => _$OthersStatusModelToJson(this);
}
// flutter clean
// flutter pub get
// flutter pub run build_runner build --delete-conflicting-outputs