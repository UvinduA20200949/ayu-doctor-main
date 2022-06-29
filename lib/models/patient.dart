// To parse this JSON data, do
//
//     final patient = patientFromJson(jsonString);

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

List<Patient> patientFromJson(String str) =>
    List<Patient>.from(json.decode(str).map((x) => Patient.fromJson(x)));

String patientToJson(List<Patient> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Patient {
  Patient({
    required this.bloodType,
    required this.dateOfBirth,
    required this.email,
    required this.gender,
    required this.name,
    required this.nic,
    required this.phoneNumber,
    required this.profilePictureUrl,
    required this.uid,
    required this.address,
    required this.age,
  });

  String bloodType;
  Timestamp dateOfBirth;
  String email;
  String gender;
  String name;
  String nic;
  String phoneNumber;
  String profilePictureUrl;
  String uid;
  String address;
  int age;

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
      bloodType: json["blood_type"],
      dateOfBirth: json["date_of_birth"],
      email: json["email"],
      gender: json["gender"],
      name: json["name"],
      nic: json["nic"],
      phoneNumber: json["phone_number"],
      profilePictureUrl: json["profilePictureUrl"],
      uid: json["uid"],
      address: json['address'],
      age: json['age']);

  Map<String, dynamic> toJson() => {
        "blood_type": bloodType,
        "date_of_birth": dateOfBirth,
        "email": email,
        "gender": gender,
        "name": name,
        "nic": nic,
        "phone_number": phoneNumber,
        "profilePictureUrl": profilePictureUrl,
        "uid": uid,
        'address': address,
        'age': age,
      };
}
