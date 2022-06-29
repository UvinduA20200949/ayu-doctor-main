import 'dart:developer';
import 'dart:io';

import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/screens/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../utils/colors.dart';

// ignore: must_be_immutable
class UploadBankDetails extends StatefulWidget {
  String firstname,
      lastname,
      email,
      address,
      phone,
      slmc,
      speciality,
      university,
      qualify,
      uid,
      profession;
  double consult;
  bool isPgimCertified;
  File? file1, file2, file3, file4, file5, file6;
  UploadBankDetails(
      {Key? key,
      required this.firstname,
      required this.lastname,
      required this.email,
      required this.phone,
      required this.address,
      required this.slmc,
      required this.speciality,
      required this.university,
      required this.qualify,
      required this.consult,
      required this.uid,
      required this.profession,
      required this.isPgimCertified,
      required this.file1,
      required this.file2,
      required this.file3,
      required this.file4,
      required this.file5,
      required this.file6})
      : super(key: key);

  @override
  _UploadBankDetailsState createState() => _UploadBankDetailsState();
}

class _UploadBankDetailsState extends State<UploadBankDetails> {
  TextEditingController accountController = TextEditingController();
  TextEditingController banknameController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController holderController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  UploadTask? task;
  bool isValidated = false;
  bool isUploading = false;
  String downloadUrl1 = '';
  String downloadUrl2 = '';
  String downloadUrl3 = '';
  String downloadUrl4 = '';
  String downloadUrl5 = '';
  String downloadUrl6 = '';

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Form(
          key: _key,
          child: Stack(alignment: Alignment.center, children: [
            Column(children: <Widget>[
              const SingleChildScrollView(
                reverse: true,
              ),
              Container(
                padding: const EdgeInsets.all(10.0),
                height: _height * 0.21,
                width: _width,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.bottomRight,
                        colors: [primaryColor, secondaryColor]),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(45),
                      bottomRight: Radius.circular(45),
                    )),
                child: LayoutBuilder(
                    builder: (context, constraints) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                margin:
                                    const EdgeInsets.only(left: 20, top: 35),
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 15,
                                  child: Icon(
                                    Icons.arrow_back_ios_new_outlined,
                                    size: 18,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const <Widget>[
                                  Text(
                                    'LETS UPLOAD YOUR\nBANK DETAILS',
                                    style: TextStyle(
                                      fontFamily: 'InterBold',
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )),
              ),
              if (!isKeyboard)
                Center(
                  child: Container(
                    margin: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    height: _height * 0.2,
                    width: _width * 0.5,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/soil.png'),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextFormField(
                    controller: accountController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateAccount,
                    decoration: InputDecoration(
                        hintText: 'Account Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextFormField(
                    controller: banknameController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateBankname,
                    decoration: InputDecoration(
                        hintText: 'Bank Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextFormField(
                    controller: branchController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateBranch,
                    decoration: InputDecoration(
                        hintText: 'Branch Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    keyboardType: TextInputType.text,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 15,
                  child: TextFormField(
                    controller: holderController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: validateHolder,
                    decoration: InputDecoration(
                        hintText: 'Account Holders Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        )),
                    keyboardType: TextInputType.name,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: moveToNextScreen,
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    ),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: isUploading == true
                      ? const CircularProgressIndicator(
                          color: secondaryColor,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const Text(
                              'Complete registration',
                              style: TextStyle(
                                color: secondaryColor,
                                fontSize: 24,
                                // fontFamily: 'InterBold',
                              ),
                            ),
                            SizedBox(
                              width: _width * 0.01,
                            ),
                            const SizedBox(
                              height: 30.0,
                              width: 30.0,
                              child: Icon(
                                Icons.arrow_forward_rounded,
                                color: secondaryColor,
                              ),
                            ),
                          ],
                        )),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom)),
              const SizedBox(
                height: 0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 280),
                child: Container(
                  height: _width * 0.2,
                  width: _width * 0.2,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/app_icon.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ]),
          ]),
        ));
  }

  Future uploadFile1() async {
    if (widget.file1 == null) return;

    final fileName = p.basename(widget.file1!.path);
    final destination =
        'doctors_sign_up_documents/${widget.uid}/gmc_license/$fileName';

    task = FirebaseApi.uploadFile(destination, widget.file1!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    downloadUrl1 = urlDownload;
    log('Download-Link - File1 ................ $urlDownload');
  }

  Future uploadFile2() async {
    if (widget.file2 == null) return;

    final fileName = p.basename(widget.file2!.path);
    final destination =
        'doctors_sign_up_documents/${widget.uid}/nic_or_passport/$fileName';

    task = FirebaseApi.uploadFile(destination, widget.file2!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    downloadUrl2 = urlDownload;
    log('Download-Link - File2 ................ $urlDownload');
  }

  Future uploadFile3() async {
    if (widget.file3 == null) return;

    final fileName = p.basename(widget.file3!.path);
    final destination =
        'doctors_sign_up_documents/${widget.uid}/signature/$fileName';

    task = FirebaseApi.uploadFile(destination, widget.file3!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    downloadUrl3 = urlDownload;
    log('Download-Link - File3 ................ $urlDownload');
  }

  Future uploadFile4() async {
    if (widget.file4 == null) return;

    final fileName = p.basename(widget.file4!.path);
    final destination =
        'doctors_sign_up_documents/${widget.uid}/official_seal/$fileName';

    task = FirebaseApi.uploadFile(destination, widget.file4!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    downloadUrl4 = urlDownload;
    log('Download-Link - File4 ................ $urlDownload');
  }

  Future uploadFile5() async {
    if (widget.file5 == null) return;

    final fileName = p.basename(widget.file5!.path);
    final destination =
        'doctors_sign_up_documents/${widget.uid}/slmc_certificate/$fileName';

    task = FirebaseApi.uploadFile(destination, widget.file5!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    downloadUrl5 = urlDownload;
    log('Download-Link - File5 ................ $urlDownload');
  }

  Future uploadFile6() async {
    if (widget.file6 == null) return;

    final fileName = p.basename(widget.file6!.path);
    final destination = 'doctors_profile_pictures/${widget.uid}/$fileName';

    task = FirebaseApi.uploadFile(destination, widget.file6!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    downloadUrl6 = urlDownload;
    log('Download-Link - File6 ................ $urlDownload');
  }

  checkvalidation() {
    if (_key.currentState!.validate()) {
      setState(() {
        isValidated = true;
      });
    } else {
      setState(() {
        isValidated = false;
      });
    }
  }

  Future moveToNextScreen() async {
    checkvalidation();
    if (isValidated) {
      addBankDetailsToFirestore();
      uploadToStorage().whenComplete(() {
        setState(() {
          isUploading = false;
        });
        addDoctorToFirestore();
        addBankDocumentsToFirestore(downloadUrl1, downloadUrl2, downloadUrl3,
            downloadUrl4, downloadUrl5);
        log('--------- DONE ---------');
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => const SignIn(),
          ),
          (route) => false,
        );
      });
    }
  }

  Future uploadToStorage() async {
    setState(() {
      isUploading = true;
    });
    await uploadFile1();
    await uploadFile2();
    await uploadFile3();
    await uploadFile4();
    await uploadFile5();
    await uploadFile6();
  }

  Future addBankDetailsToFirestore() async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.uid)
        .collection('bank_details')
        .add({
      'account_number': accountController.text,
      'bank_name': banknameController.text,
      'branch_name': branchController.text,
      'account_holders_name': holderController.text,
    });
  }

  Future addBankDocumentsToFirestore(
      String url1, String url2, String url3, String url4, String url5) async {
    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(widget.uid)
        .collection('requested_documents')
        .add({
      'gmc_license': downloadUrl1,
      'nic_or_passport': downloadUrl2,
      'signature': downloadUrl3,
      'official_seal': downloadUrl4,
      'slmc_certificate': downloadUrl5
    });
  }

  Future addDoctorToFirestore() async {
    log(widget.uid);
    final docUser =
        FirebaseFirestore.instance.collection('doctors').doc(widget.uid);

    final doctor = Doctor(
      name: '${widget.firstname} ${widget.lastname}',
      email: widget.email,
      profilePictureUrl: downloadUrl6,
      speciality: widget.speciality,
      about: '',
      slmc: widget.slmc,
      phoneNumber: widget.phone,
      medicalSchool: widget.university,
      qualification: widget.qualify,
      consultationFee: widget.consult,
      profession: widget.profession,
      consultants: 0,
      experience: 0,
      ratings: 0.0,
      uid: widget.uid,
      isVerified: false,
      isPgimCertified: widget.isPgimCertified,
      online: false,
    );

    final json = doctor.toJson();
    await docUser.set(json);
  }

  String? validateAccount(String? formAccount) {
    if (formAccount == null || formAccount.isEmpty) {
      return "Field can't be empty";
    } else if (formAccount.length < 12) {
      return 'Enter at least 12 digits';
    }
    return null;
  }

  String? validateBankname(String? formBankname) {
    String pattern = '[a-zA-Z]';
    RegExp regex = RegExp(pattern);
    if (formBankname == null ||
        formBankname.isEmpty ||
        !regex.hasMatch(formBankname)) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validateBranch(String? formBranch) {
    String pattern = '[a-zA-Z]';
    RegExp regex = RegExp(pattern);
    if (formBranch == null ||
        formBranch.isEmpty ||
        !regex.hasMatch(formBranch)) {
      return "Field can't be empty";
    }
    return null;
  }

  String? validateHolder(String? formHolder) {
    String pattern = '[a-zA-Z]';
    RegExp nameRegExp = RegExp(pattern);
    if (formHolder == null ||
        formHolder.isEmpty ||
        !nameRegExp.hasMatch(formHolder)) {
      return "Field can't be empty";
    }
    return null;
  }
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
      // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
