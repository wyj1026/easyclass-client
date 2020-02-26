import 'package:easy_class/homework/detail/student/homework_detail2commit.dart';
import 'package:easy_class/models/homework.dart';
import 'package:easy_class/models/question.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'detail/student/homework_detail_judged.dart';
import 'detail/student/homework_detail_not_judged.dart';
import 'detail/teacher/homework_detail2judge.dart';
import 'detail/teacher/homework_detail_judged.dart';
import 'detail/teacher/homework_detail_pubed.dart';

class HomeworkDetail {
  static Widget get(int stat, Homework homework, List<Question> questions) {
    if (stat == 0) {
      return HomeworkDetail2Commit(homework: homework, questions: questions,);
    }
    else if (stat == 1) {
      return HomeworkNotJudgedStudent(homework: homework, questions: questions,);
    }
    else if (stat == 2) {
      return HomeworkJudged(homework: homework, questions: questions,);
    }
    else if (stat == 3) {
      return HomeworkDetailPubed(homework: homework, questions: questions,);
    }
    else if (stat == 4) {
      return HomeworkDetail2Judge(homework: homework, questions: questions,);
    }
    else if (stat == 5) {
      return HomeworkDetailJudgedTeacher(homework: homework, questions: questions,);
    }
    else {
      return null;
    }
  }
}