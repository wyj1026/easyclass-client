// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'homework.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Homework _$HomeworkFromJson(Map<String, dynamic> json) {
  return Homework()
    ..id = json['id'] as num
    ..classname = json['classname'] as String
    ..class_id = json['classId'] as num
    ..homework_title = json['homeworkTitle'] as String
    ..gmt_create = json['gmtCreate'] as num
    ..question_number = json['questionNumber'] as num
    ..total_grade = json['totalGrade'] as num
    ..gmt_start_upload = json['gmtStartUpload'] as num
    ..gmt_stop_upload = json['gmtStopUpload'] as num
    ..enable_communicate = json['enableCommunicate'] as bool
    ..enable_auto_judge = json['enableAutoJudge'] as bool
    ..enable_judge_by_others = json['enableJudgeByOthers'] as bool
    ..tag = json['tag'] as num;
}

Map<String, dynamic> _$HomeworkToJson(Homework instance) => <String, dynamic>{
      'id': instance.id,
      'classname': instance.classname,
      'classId': instance.class_id,
      'homeworkTitle': instance.homework_title,
      'gmtCreate': instance.gmt_create,
      'questionNumber': instance.question_number,
      'totalGrade': instance.total_grade,
      'gmtStartUpload': instance.gmt_start_upload,
      'gmtStopUpload': instance.gmt_stop_upload,
      'enableCommunicate': instance.enable_communicate,
      'enableAutoJudge': instance.enable_auto_judge,
      'enableJudgeByOthers': instance.enable_judge_by_others,
      'tag': instance.tag
    };
