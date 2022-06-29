import 'dart:io';

import 'package:ayu_doctor/backend/chat_encryption.dart';
import 'package:ayu_doctor/models/chat_message.dart';
import 'package:ayu_doctor/models/patient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class BookingBackend {
  final currentDoctor = FirebaseAuth.instance.currentUser!;

//Doctors app Booking screen
  //Read patient id from firebase (doctoes-->doctorUID-->patients) and return the list of Patients id s
  Stream<List<String>> readPatientIds() => FirebaseFirestore.instance
      .collection('doctors')
      .doc(currentDoctor.uid)
      .collection('patients')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());

  //get the patients details from firebase with patient UID
  Stream<Patient> getPatientData(String patientId) => FirebaseFirestore.instance
      .collection('users')
      .doc(patientId)
      .snapshots()
      .map((snapshot) => Patient.fromJson(snapshot.data()!));

  //Chat part
  //get the chats
  Stream<List<ChatMessage>> readChats(String patientUid) =>
      FirebaseFirestore.instance
          .collection('users')
          .doc(patientUid)
          .collection('messages')
          .doc(currentDoctor.uid)
          .collection('message')
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => ChatMessage.fromJson(doc.data()))
              .toList());
  //send message
  Future sendMessage(String textMessage, String patientId,
      PlatformFile? pickedFile, UploadTask? uploadTask) async {
    String urlDownload = "";
    if (pickedFile != null) {
      // pickedFile = null;
      try {
        final path =
            'messagesStorage/$patientId/${currentDoctor.uid}/${DateTime.now().toString()}';
        final file = File(pickedFile.path!);
        final ref = FirebaseStorage.instance.ref().child(path);
        uploadTask = ref.putFile(file);

        final snapShot = await uploadTask.whenComplete(() => {});

        urlDownload = await snapShot.ref.getDownloadURL();
        debugPrint(urlDownload);
      } catch (ex) {
        debugPrint("EXCEPTION IN FILE UPLOADING :" + ex.toString());
      } finally {
        debugPrint("done");
      }
    }

    if (textMessage != "" || pickedFile != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(patientId)
          .collection('messages')
          .doc(currentDoctor.uid)
          .collection('message')
          .add({
        'text': ChatMessageEncryptAndDecrypt().encryptionText(textMessage),
        'documents': urlDownload,
        'time': DateTime.now(),
        'sendBy': 'doctor',
      });

      pickedFile = null;
    }
  }

  //download files
  Future downloadFileInChatt(String url) async {
    debugPrint(url);
    try {
      final status = await Permission.storage.request();

      if (status.isGranted) {
        debugPrint("access granted");
        final baseStorage = await getExternalStorageDirectory();

        try {
          // ignore: unused_local_variable
          final id = await FlutterDownloader.enqueue(
            url: url,
            savedDir: baseStorage!.path,
            saveInPublicStorage: true,
          );
        } catch (error) {
          debugPrint(error.toString());
        }
      } else {
        debugPrint("No Permission Granted");
      }
    } catch (e) {
      debugPrint("exception : " + e.toString());
    }
  }
}
