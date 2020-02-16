drop table class_homework;

CREATE TABLE class_homework
(
  `id`         int(11)       NOT NULL AUTO_INCREMENT,
  `gmt_create` bigint(14) NOT NULL ,
  `class_id`     int(11) NOT NULL,
  `classname`       varchar(1024) NOT NULL,
  `homework_title`   varchar(1024) NOT NULL,
  `question_number`   int(11) NOT NULL,
  `total_grade`   int(11) NOT NULL,
  `gmt_start_upload` bigint(14) not null ,
  `gmt_stop_upload`  bigint(14) not null ,
  `enable_communicate` int(1) not null ,
  `enable_auto_judge` int(1) not null ,
  `enable_judge_by_others` int(1) not null ,
  PRIMARY KEY (`id`)
)
  DEFAULT CHARSET = utf8;

insert into class_homework
values (1,
        1579610044222,
        1,
        '数据结构',
        '堆和栈',
        1,
        100,
        1579610044222,
        1579610044222,
        1,
        1,
        1);


select * from class_homework;