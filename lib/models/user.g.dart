// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..id = json['id'] as num
    ..name = json['name'] as String
    ..nickname = json['nickname'] as String
    ..password = json['password'] as String
    ..phone = json['phone'] as String
    ..email = json['email'] as String
    ..avatar_url = json['avatar_url'] as String
    ..description = json['description'] as String;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nickname': instance.nickname,
      'password': instance.password,
      'phone': instance.phone,
      'email': instance.email,
      'avatar_url': instance.avatar_url,
      'description': instance.description
    };
