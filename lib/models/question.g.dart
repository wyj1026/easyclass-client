// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) {
  return Question()
    ..id = json['id'] as num
    ..gmt_create = json['gmtCreate'] as num
    ..classname = json['classname'] as String
    ..class_id = json['classId'] as num
    ..question = json['question'] as String
    ..answer = json['answer'] as String
    ..grade = json['grade'] as num
    ..question_number = json['questionNumber'] as num
    ..is_objective = json['isObjective'] as bool;
}

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'gmtCreate': instance.gmt_create,
      'classname': instance.classname,
      'classId': instance.class_id,
      'question': instance.question,
      'answer': instance.answer,
      'grade': instance.grade,
      'questionNumber': instance.question_number,
      'isObjective': instance.is_objective
    };
