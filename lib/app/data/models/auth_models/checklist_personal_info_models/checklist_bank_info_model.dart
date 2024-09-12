// To parse this JSON data, do
//
//     final bankInfoStatusModel = bankInfoStatusModelFromJson(jsonString);

import 'dart:convert';

BankInfoStatusModel bankInfoStatusModelFromJson(String str) => BankInfoStatusModel.fromJson(json.decode(str));

String bankInfoStatusModelToJson(BankInfoStatusModel data) => json.encode(data.toJson());

class BankInfoStatusModel {
  bool? checklistStatus;
  String? bankName;
  String? bankAccountNo;
  String? bankAccountHolderName;
  String? bankStatementUrl;

  BankInfoStatusModel({
    this.checklistStatus,
    this.bankName,
    this.bankAccountNo,
    this.bankAccountHolderName,
    this.bankStatementUrl,
  });

  factory BankInfoStatusModel.fromJson(Map<String, dynamic> json) => BankInfoStatusModel(
    checklistStatus: json["checklist_status"],
    bankName: json["bank_name"],
    bankAccountNo: json["bank_account_no"],
    bankAccountHolderName: json["bank_account_holder_name"],
    bankStatementUrl: json["bank_statement_url"],
  );

  Map<String, dynamic> toJson() => {
    "checklist_status": checklistStatus,
    "bank_name": bankName,
    "bank_account_no": bankAccountNo,
    "bank_account_holder_name": bankAccountHolderName,
    "bank_statement_url": bankStatementUrl,
  };
}
