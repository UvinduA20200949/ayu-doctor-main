import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/resources/firebase_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  Future<User> getCurrentUser() => _firebaseMethods.getCurrentUser();

  Future<Doctor> getDoctorDetails() => _firebaseMethods.getDoctorDetails();
}
