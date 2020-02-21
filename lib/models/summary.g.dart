// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Summary _$SummaryFromJson(Map<String, dynamic> json) {
  return Summary()
    ..id = json['id'] as num
    ..classname = json['classname'] as String
    ..class_id = json['classId'] as num
    ..homework_id = json['homeworkId'] as num
    ..user_id = json['userId'] as num
    ..objective_grage = json['objectiveGrage'] as num
    ..non_objective_grage = json['nonObjectiveGrage'] as num
    ..username = json['username'] as String
    ..comment = json['comment'] as String;
}

Map<String, dynamic> _$SummaryToJson(Summary instance) => <String, dynamic>{
      'id': instance.id,
      'classname': instance.classname,
      'classId': instance.class_id,
      'homeworkId': instance.homework_id,
      'userId': instance.user_id,
      'objectiveGrage': instance.objective_grage,
      'nonObjectiveGrage': instance.non_objective_grage,
      'username': instance.username,
      'comment': instance.comment
    };
