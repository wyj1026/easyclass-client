// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Class _$ClassFromJson(Map<String, dynamic> json) {
  return Class()
    ..id = json['id'] as num
    ..classname = json['classname'] as String
    ..class_date = json['classDate'] as String
    ..gmt_start = json['gmtStart'] as num
    ..avatar_url = json['avatarUrl'] as String
    ..class_duration = json['classDuration'] as String
    ..description = json['description'] as String
    ..school = json['school'] as String;
}

Map<String, dynamic> _$ClassToJson(Class instance) => <String, dynamic>{
      'id': instance.id,
      'classname': instance.classname,
      'classDate': instance.class_date,
      'gmtStart': instance.gmt_start,
      'avatarUrl': instance.avatar_url,
      'classDuration': instance.class_duration,
      'description': instance.description,
      'school': instance.school
    };
