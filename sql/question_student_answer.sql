drop table question_student_answer;

CREATE TABLE question_student_answer
(
  `id`                      int(11)       NOT NULL AUTO_INCREMENT,
  `class_id`                int(11)       NOT NULL,
  `classname`               varchar(1024) NOT NULL,
  `homework_id`             int(11)       NOT NULL,
  `user_id`                 int(11)       NOT NULL,
  `username`                varchar(1024) NOT NULL,
  `homework_question_id`    int(11)       NOT NULL,
  `student_question_answer` varchar(1024) NOT NULL,
  `grage`                   int(11)                default NULL,
  `gmt_upload`              bigint(14),
  `gmt_judge`               bigint(14),
  `comment`                 varchar(1024)          default null,

  PRIMARY KEY (`id`)
)
  DEFAULT CHARSET = utf8;

insert into question_student_answer
values (1, '1', '数据结构', 1, 1, '王一杰', '1', 'Answer: 这道题目来自于bla。。。', 10, 1579610044222, 1579610044222, '');


select *
from question_student_answer;