import 'package:json_annotation/json_annotation.dart';

part 'classRole.g.dart';

@JsonSerializable()
class ClassRole {
    ClassRole();

    num id;
    @JsonKey(name: 'userId') num user_id;
    String classname;
    String username;
    String school;
    String role;
    @JsonKey(name: 'classId') num class_id;
    
    factory ClassRole.fromJson(Map<String,dynamic> json) => _$ClassRoleFromJson(json);
    Map<String, dynamic> toJson() => _$ClassRoleToJson(this);
}
