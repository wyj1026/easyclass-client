// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) {
  return Answer()
    ..id = json['id'] as num
    ..classname = json['classname'] as String
    ..class_id = json['classId'] as num
    ..homework_id = json['homeworkId'] as num
    ..user_id = json['userId'] as num
    ..username = json['username'] as String
    ..homework_questionId = json['homeworkQuestionId'] as num
    ..student_question_answer = json['studentQuestionAnswer'] as String
    ..grade = json['grade'] as num
    ..gmt_upload = json['gmtUpload'] as num
    ..gmt_judge = json['gmtJudge'] as num
    ..comment = json['comment'] as String;
}

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'classname': instance.classname,
      'classId': instance.class_id,
      'homeworkId': instance.homework_id,
      'userId': instance.user_id,
      'username': instance.username,
      'homeworkQuestionId': instance.homework_questionId,
      'studentQuestionAnswer': instance.student_question_answer,
      'grade': instance.grade,
      'gmtUpload': instance.gmt_upload,
      'gmtJudge': instance.gmt_judge,
      'comment': instance.comment
    };
