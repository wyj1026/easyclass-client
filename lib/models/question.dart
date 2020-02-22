import 'package:json_annotation/json_annotation.dart';

part 'question.g.dart';

@JsonSerializable()
class Question {
    Question();

    num id;
    @JsonKey(name: 'gmtCreate') num gmt_create;
    String classname;
    @JsonKey(name: 'classId') num class_id;
    String question;
    Map<String,dynamic> answer;
    num grade;
    @JsonKey(name: 'questionNumber') num question_number;
    @JsonKey(name: 'isObjective') bool is_objective;
    @JsonKey(name: 'isMultity') bool is_multity;
    
    factory Question.fromJson(Map<String,dynamic> json) => _$QuestionFromJson(json);
    Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
