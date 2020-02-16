drop table class;

CREATE TABLE class
(
  `id`         int(11)       NOT NULL AUTO_INCREMENT,
  `classname`       varchar(1024) NOT NULL,
  `gmt_start`       bigint(14) NOT NULL,
  `class_date`   varchar(1024) NOT NULL,
  `class_duration`      int(11)   not null,
  `avatar_url` varchar(1024) default 'default_avatar_url.jpg',

  PRIMARY KEY (`id`)
)
  DEFAULT CHARSET = utf8;

insert into class
values (1,
        '数据结构',
        1579610044222,
        '周一上午第二节',
        16,
        'https://b-ssl.duitang.com/uploads/item/201810/18/20181018162951_kgwzm.thumb.700_0.jpeg');


select * from class;