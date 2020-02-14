// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) {
  return Class()
    ..id = json['id'] as num
    ..classname = json['classname'] as String
    ..class_date = json['class_date'] as String
    ..gmt_start = json['gmt_start'] as num
    ..avatar_url = json['avatar_url'] as String
    ..class_duration = json['class_duration'] as num;
}

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'id': instance.id,
      'classname': instance.classname,
      'class_date': instance.class_date,
      'gmt_start': instance.gmt_start,
      'avatar_url': instance.avatar_url,
      'class_duration': instance.class_duration
    };
