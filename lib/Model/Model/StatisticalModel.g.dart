// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatisticalModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticalModel _$StatisticalModelFromJson(Map<String, dynamic> json) =>
    StatisticalModel(
      chatCountOld: json['chatCountOld'] as int,
      chatCountNew: json['chatCountNew'] as int,
      imageCountOld: json['imageCountOld'] as int,
      imageCountNew: json['imageCountNew'] as int,
      videoCountOld: json['videoCountOld'] as int,
      videoCountNew: json['videoCountNew'] as int,
      fileCountOld: json['fileCountOld'] as int,
      fileCountNew: json['fileCountNew'] as int,
    );

Map<String, dynamic> _$StatisticalModelToJson(StatisticalModel instance) =>
    <String, dynamic>{
      'chatCountOld': instance.chatCountOld,
      'chatCountNew': instance.chatCountNew,
      'imageCountOld': instance.imageCountOld,
      'imageCountNew': instance.imageCountNew,
      'videoCountOld': instance.videoCountOld,
      'videoCountNew': instance.videoCountNew,
      'fileCountOld': instance.fileCountOld,
      'fileCountNew': instance.fileCountNew,
    };
