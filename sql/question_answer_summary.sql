drop table question_student_summary;

CREATE TABLE question_student_summary
(
  `id`                      int(11)       NOT NULL AUTO_INCREMENT,
  `class_id`                int(11)       NOT NULL,
  `classname`               varchar(1024) NOT NULL,
  `homework_id`             int(11)       NOT NULL,
  `user_id`                 int(11)       NOT NULL,
  `username`                varchar(1024) NOT NULL,
  `objective_grage`    int(11)       default NULL,
  `non_objective_grage`    int(11)       default NULL,
  `comment`                 varchar(1024)          default null,

  PRIMARY KEY (`id`)
)
  DEFAULT CHARSET = utf8;

insert into question_student_summary
values (1, '1', '数据结构', 1, 1, '王一杰', 0, 0, '');


select *
from question_student_summary;