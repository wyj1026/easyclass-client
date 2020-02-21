import 'package:json_annotation/json_annotation.dart';

part 'summary.g.dart';

@JsonSerializable()
class Summary {
    Summary();

    num id;
    String classname;
    @JsonKey(name: 'classId') num class_id;
    @JsonKey(name: 'homeworkId') num homework_id;
    @JsonKey(name: 'userId') num user_id;
    @JsonKey(name: 'objectiveGrage') num objective_grage;
    @JsonKey(name: 'nonObjectiveGrage') num non_objective_grage;
    String username;
    String comment;
    
    factory Summary.fromJson(Map<String,dynamic> json) => _$SummaryFromJson(json);
    Map<String, dynamic> toJson() => _$SummaryToJson(this);
}
