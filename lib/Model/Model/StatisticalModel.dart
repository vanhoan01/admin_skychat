// ignore_for_file: file_names

import 'package:json_annotation/json_annotation.dart';

part 'StatisticalModel.g.dart';

@JsonSerializable()
class StatisticalModel {
  StatisticalModel({
    required this.chatCountOld,
    required this.chatCountNew,
    required this.imageCountOld,
    required this.imageCountNew,
    required this.videoCountOld,
    required this.videoCountNew,
    required this.fileCountOld,
    required this.fileCountNew,
  });
  final int chatCountOld;
  final int chatCountNew;
  final int imageCountOld;
  final int imageCountNew;
  final int videoCountOld;
  final int videoCountNew;
  final int fileCountOld;
  final int fileCountNew;

  factory StatisticalModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticalModelFromJson(json);

  Map<String, dynamic> toJson() => _$StatisticalModelToJson(this);
}
// flutter clean
// flutter pub get
// flutter pub run build_runner build --delete-conflicting-outputs