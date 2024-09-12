// To parse this JSON data, do
//
//     final checklistOnboardingModel = checklistOnboardingModelFromJson(jsonString);

import 'dart:convert';

List<ChecklistOnboardingModel> checklistOnboardingModelFromJson(String str) => List<ChecklistOnboardingModel>.from(json.decode(str).map((x) => ChecklistOnboardingModel.fromJson(x)));

String checklistOnboardingModelToJson(List<ChecklistOnboardingModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ChecklistOnboardingModel {
  String? uuid;
  String? title;
  int? score;
  int? totalScore;
  int? isPassed;
  bool? noQuiz;

  ChecklistOnboardingModel({
    this.uuid,
    this.title,
    this.score,
    this.totalScore,
    this.isPassed,
    this.noQuiz,
  });

  factory ChecklistOnboardingModel.fromJson(Map<String, dynamic> json) => ChecklistOnboardingModel(
    uuid: json["uuid"],
    title: json["title"],
    score: json["score"],
    totalScore: json["total_score"],
    isPassed: json["is_passed"],
    noQuiz: json["no_quiz"],
  );

  Map<String, dynamic> toJson() => {
    "uuid": uuid,
    "title": title,
    "score": score,
    "total_score": totalScore,
    "is_passed": isPassed,
    "no_quiz": noQuiz,
  };
}
