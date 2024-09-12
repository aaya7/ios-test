// To parse this JSON data, do
//
//     final quizOnboardingResultModel = quizOnboardingResultModelFromJson(jsonString);

import 'dart:convert';

QuizOnboardingResultModel quizOnboardingResultModelFromJson(String str) => QuizOnboardingResultModel.fromJson(json.decode(str));

String quizOnboardingResultModelToJson(QuizOnboardingResultModel data) => json.encode(data.toJson());

class QuizOnboardingResultModel {
  int? score;
  int? totalScore;
  bool? isPassed;

  QuizOnboardingResultModel({
    this.score,
    this.totalScore,
    this.isPassed,
  });

  factory QuizOnboardingResultModel.fromJson(Map<String, dynamic> json) => QuizOnboardingResultModel(
    score: json["score"],
    totalScore: json["total_score"],
    isPassed: json["is_passed"],
  );

  Map<String, dynamic> toJson() => {
    "score": score,
    "total_score": totalScore,
    "is_passed": isPassed,
  };
}
