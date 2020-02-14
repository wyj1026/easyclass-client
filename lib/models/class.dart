import 'package:json_annotation/json_annotation.dart';

part 'class.g.dart';

@JsonSerializable()
class Class {
    Class();

    num id;
    String classname;
    String class_date;
    num gmt_start;
    String avatar_url;
    num class_duration;
    
    factory Class.fromJson(Map<String,dynamic> json) => _$ClassFromJson(json);
    Map<String, dynamic> toJson() => _$ClassToJson(this);
}
