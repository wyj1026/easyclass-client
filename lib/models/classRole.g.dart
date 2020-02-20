// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'classRole.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ClassRole _$ClassRoleFromJson(Map<String, dynamic> json) {
  return ClassRole()
    ..id = json['id'] as num
    ..user_id = json['userId'] as num
    ..classname = json['classname'] as String
    ..username = json['username'] as String
    ..school = json['school'] as String
    ..role = json['role'] as String
    ..class_id = json['classId'] as num;
}

Map<String, dynamic> _$ClassRoleToJson(ClassRole instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.user_id,
      'classname': instance.classname,
      'username': instance.username,
      'school': instance.school,
      'role': instance.role,
      'classId': instance.class_id
    };
