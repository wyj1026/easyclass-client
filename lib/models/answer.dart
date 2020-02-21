import 'package:json_annotation/json_annotation.dart';

part 'answer.g.dart';

@JsonSerializable()
class Answer {
    Answer();

    num id;
    String classname;
    @JsonKey(name: 'classId') num class_id;
    @JsonKey(name: 'homeworkId') num homework_id;
    @JsonKey(name: 'userId') num user_id;
    String username;
    @JsonKey(name: 'homeworkQuestionId') num homework_questionId;
    @JsonKey(name: 'studentQuestionAnswer') String student_question_answer;
    @JsonKey(name: 'grade') num grade;
    @JsonKey(name: 'gmtUpload') num gmt_upload;
    @JsonKey(name: 'gmtJudge') num gmt_judge;
    String comment;
    
    factory Answer.fromJson(Map<String,dynamic> json) => _$AnswerFromJson(json);
    Map<String, dynamic> toJson() => _$AnswerToJson(this);
}
