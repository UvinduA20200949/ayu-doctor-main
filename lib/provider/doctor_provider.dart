import 'package:ayu_doctor/models/doc.dart';
import 'package:flutter/widgets.dart';
import 'package:ayu_doctor/resources/firebase_repository.dart';

class DoctorProvider with ChangeNotifier {
  Doctor? _doctor;

  final FirebaseRepository _firebaseRepository = FirebaseRepository();

  Doctor? get getDoctor => _doctor;

  void refreshDoctor() async {
    Doctor doctor = await _firebaseRepository.getDoctorDetails();
    _doctor = doctor;
    notifyListeners();
  }
}
