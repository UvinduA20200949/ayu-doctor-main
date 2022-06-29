// To parse this JSON data, do
//
//     final chatMessage = chatMessageFromJson(jsonString);

// import 'dart:convert';

// List<ChatMessage> chatMessageFromJson(String str) => List<ChatMessage>.from(
//     json.decode(str).map((x) => ChatMessage.fromJson(x)));

// String chatMessageToJson(List<ChatMessage> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

import 'package:ayu_doctor/backend/chat_encryption.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  String? documents;
  String sendBy;
  String? text;
  Timestamp time;

  ChatMessage({
    this.documents,
    required this.sendBy,
    required this.text,
    required this.time,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) => ChatMessage(
        documents: json["documents"],
        sendBy: json["sendBy"],
        text: ChatMessageEncryptAndDecrypt().decryptionText(json["text"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "documents": documents,
        "sendBy": sendBy,
        "text": text,
        "time": time,
      };
}
