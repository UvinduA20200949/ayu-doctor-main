// To parse this JSON data, do
//
//     final bankCard = bankCardFromJson(jsonString);

import 'dart:convert';

// BankCard bankCardFromJson(String str) => BankCard.fromJson(json.decode(str));

String bankCardToJson(BankCard data) => json.encode(data.toJson());

class BankCard {
  BankCard({
    required this.accountHoldersName,
    required this.accountNumber,
    required this.bankName,
    required this.branchName,
    required this.docID,
  });

  String accountHoldersName;
  String accountNumber;
  String bankName;
  String branchName;
  String docID;

  factory BankCard.fromJson(Map<String, dynamic> json, String docIDd) =>
      BankCard(
          accountHoldersName: json["account_holders_name"],
          accountNumber: json["account_number"],
          bankName: json["bank_name"],
          branchName: json["branch_name"],
          docID: docIDd);

  Map<String, dynamic> toJson() => {
        "account_holders_name": accountHoldersName,
        "account_number": accountNumber,
        "bank_name": bankName,
        "branch_name": branchName,
      };
}
