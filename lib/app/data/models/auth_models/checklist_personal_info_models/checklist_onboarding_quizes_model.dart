// To parse this JSON data, do
//
//     final checklistOnboardingQuizzesModel = checklistOnboardingQuizzesModelFromJson(jsonString);

import 'dart:convert';

import 'package:get/get.dart';

ChecklistOnboardingQuizzesModel checklistOnboardingQuizzesModelFromJson(String str) => ChecklistOnboardingQuizzesModel.fromJson(json.decode(str));

String checklistOnboardingQuizzesModelToJson(ChecklistOnboardingQuizzesModel data) => json.encode(data.toJson());

class ChecklistOnboardingQuizzesModel {
  OnboardingQuiz? onboardingQuiz;
  String? onboardingVideo;

  ChecklistOnboardingQuizzesModel({
    this.onboardingQuiz,
    this.onboardingVideo,
  });

  factory ChecklistOnboardingQuizzesModel.fromJson(Map<String, dynamic> json) => ChecklistOnboardingQuizzesModel(
    onboardingQuiz: json["onboarding_quiz"] == null ? null : OnboardingQuiz.fromJson(json["onboarding_quiz"]),
    onboardingVideo: json["onboarding_video"],
  );

  Map<String, dynamic> toJson() => {
    "onboarding_quiz": onboardingQuiz?.toJson(),
    "onboarding_video": onboardingVideo,
  };
}

class OnboardingQuiz {
  String? uuid;
  List<Quiz>? quizzes;

  OnboardingQuiz({
    this.uuid,
    this.quizzes,
  });

  factory OnboardingQuiz.fromJson(Map<String, dynamic> json) => OnboardingQuiz(
    uuid: json["uuid"],
    quizzes: json["quizzes"] == null ? [] : List<Quiz>.from(json["quizzes"]!.map((x) => Quiz.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "quizzes": quizzes == null ? [] : List<dynamic>.from(quizzes!.map((x) => x.toJson())),
  };
}

class Quiz {
  String? question;
  int? answer;
  List<String>? choices;
  bool? isCorrect;
  RxString? myAnswers;
  int? indexAnswer;

  Quiz({
    this.question,
    this.answer,
    this.choices,
    this.isCorrect,
    this.myAnswers,
    this.indexAnswer,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
    question: json["question"],
    answer: json["answer"],
    choices: json["choices"] == null ? [] : List<String>.from(json["choices"]!.map((x) => x)),
    isCorrect: json["is_correct"],
    myAnswers: RxString(""),
    indexAnswer: -1,
  );

  Map<String, dynamic> toJson() => {
    "question": question,
    "answer": answer,
    "choices": choices == null ? [] : List<dynamic>.from(choices!.map((x) => x)),
    "is_correct": isCorrect,
    "my_answer": myAnswers?.value,
    "index_answer": indexAnswer,
  };
}
