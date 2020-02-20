import 'package:json_annotation/json_annotation.dart';

part 'class.g.dart';

@JsonSerializable()
class Class {
    Class();

    num id;
    String classname;
    @JsonKey(name: 'classDate') String class_date;
    @JsonKey(name: 'gmtStart') num gmt_start;
    @JsonKey(name: 'avatarUrl') String avatar_url;
    @JsonKey(name: 'classDuration') String class_duration;
    String description;
    String school;
    
    factory Class.fromJson(Map<String,dynamic> json) => _$ClassFromJson(json);
    Map<String, dynamic> toJson() => _$ClassToJson(this);
}
