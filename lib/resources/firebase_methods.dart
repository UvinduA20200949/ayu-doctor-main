import 'package:ayu_doctor/models/doc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    User currentUser;
    currentUser = _auth.currentUser!;
    return currentUser;
  }

  Future<Doctor> getDoctorDetails() async {
    User currentUser = await getCurrentUser();

    DocumentSnapshot data = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(currentUser.uid)
        .get();

    var json = data.data() as Map;
    return Doctor(
        name: json['name'],
        email: json['email'],
        profilePictureUrl: json['profile_picture_url'],
        speciality: json['speciality'],
        about: json['about'],
        slmc: json['slmc'],
        phoneNumber: json['phone_number'],
        profession: json['profession'],
        medicalSchool: json['medical_school'],
        qualification: json['qualification'],
        consultationFee: json['consultation_fee'] as double,
        consultants: json['consultants'] as int,
        experience: json['experience'] as int,
        ratings: json['ratings'] as double,
        uid: json['uid'],
        isVerified: json['is_verified'] as bool,
        isPgimCertified: json['is_pgim_certified'] as bool,
        online: json['online'] as bool);
  }
}
