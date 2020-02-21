import 'package:json_annotation/json_annotation.dart';

part 'homework.g.dart';

@JsonSerializable()
class Homework {
    Homework();

    num id;
    String classname;
    @JsonKey(name: 'classId') num class_id;
    @JsonKey(name: 'homeworkTitle') String homework_title;
    @JsonKey(name: 'gmtCreate') num gmt_create;
    @JsonKey(name: 'questionNumber') num question_number;
    @JsonKey(name: 'totalGrade') num total_grade;
    @JsonKey(name: 'gmtStartUpload') num gmt_start_upload;
    @JsonKey(name: 'gmtStopUpload') num gmt_stop_upload;
    @JsonKey(name: 'enableCommunicate') bool enable_communicate;
    @JsonKey(name: 'enableAutoJudge') bool enable_auto_judge;
    @JsonKey(name: 'enableJudgeByOthers') bool enable_judge_by_others;
    
    factory Homework.fromJson(Map<String,dynamic> json) => _$HomeworkFromJson(json);
    Map<String, dynamic> toJson() => _$HomeworkToJson(this);
}
