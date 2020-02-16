drop table homework_question_answer;

CREATE TABLE homework_question_answer
(
  `id`         int(11)       NOT NULL AUTO_INCREMENT,
  `gmt_create` bigint(14) NOT NULL ,
  `class_id`     int(11) NOT NULL,
  `classname`       varchar(1024) NOT NULL,
  `homeword_id`     int(11) NOT NULL,
  `question_number`     int(11) NOT NULL,
  `question`   varchar(1024) NOT NULL,
  `answer`   varchar(1024) NOT NULL,
  `grade`   int(11) NOT NULL,
  `is_objective` int(1) NOT NULL ,
  PRIMARY KEY (`id`)
)
  DEFAULT CHARSET = utf8;

insert into homework_question_answer
values (1,
        1579610044222,
        1,
        '数据结构',
        1,
        '堆的特点',
        'A',
        10,
        1);


select * from homework_question_answer;