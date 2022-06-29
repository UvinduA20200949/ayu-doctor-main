import 'dart:io' as io;
import 'package:ayu_doctor/screens/upload_bank_details.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class UploadDocuments extends StatefulWidget {
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
  UploadDocuments({
    Key? key,
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
    required this.isPgimCertified,
    required this.uid,
    required this.profession,
  }) : super(key: key);

  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  io.File? file1, file2, file3, file4, file5, file6;
  bool file1IsValid = false;
  bool file2IsValid = false;
  bool file3IsValid = false;
  bool file4IsValid = false;
  bool file5IsValid = false;
  bool file6IsValid = false;
  bool isCheck = false;
  UploadTask? task;
  io.File? file;
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(alignment: Alignment.center, children: [
          Column(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              height: _height * 0.2,
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
                              margin: const EdgeInsets.only(left: 20, top: 35),
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
                                  'LETS UPLOAD YOUR\n DOCUMENTS',
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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: selectFile6,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const Text("Profile Picture",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2),
                            Image.asset(
                                "assets/icons/Icon feather-upload-cloud-1.png")
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: selectFile1,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const Text("GMC License",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 1.7),
                            Image.asset(
                                "assets/icons/Icon feather-upload-cloud-1.png")
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: selectFile2,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const Text("NIC/Passport Copy",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2),
                            Image.asset(
                                "assets/icons/Icon feather-upload-cloud-1.png")
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: selectFile3,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const Text("Add Your Signature",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2),
                            Image.asset(
                                "assets/icons/Icon feather-upload-cloud-1.png")
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: selectFile4,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 15,
                            ),
                            const Text("Picture Of Your Official Seal",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                                width: MediaQuery.of(context).size.width / 3.3),
                            Image.asset(
                                "assets/icons/Icon feather-upload-cloud-1.png")
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                      onTap: selectFile5,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 20,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.blueAccent),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("SLMC Certificates",
                                style: TextStyle(fontSize: 16)),
                            SizedBox(
                                width:
                                    MediaQuery.of(context).size.width / 2.05),
                            Image.asset(
                                "assets/icons/Icon feather-upload-cloud-1.png")
                          ],
                        ),
                      )),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(right: 2, left: 40),
                  child: Checkbox(
                      activeColor: secondaryText,
                      value: isCheck,
                      onChanged: (val) {
                        setState(() {
                          isCheck = val!;
                        });
                      }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'I Accept Terms & Conditions',
                          style: TextStyle(
                            fontFamily: 'InterBold',
                            fontSize: 10,
                            color: primaryText,
                          ),
                        ),
                        SizedBox(
                          width: _width * 0.01,
                        ),
                        const Text(
                          'https://hhhajha.com',
                          style: TextStyle(
                            fontFamily: 'InterBold',
                            fontSize: 10,
                            color: secondaryColor,
                          ),
                        ),
                        SizedBox(
                          width: _width * 0.01,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                // onPressed: uploadFile,
                onPressed: () {
                  if (file1IsValid &&
                      file2IsValid &&
                      file3IsValid &&
                      file4IsValid &&
                      file5IsValid) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UploadBankDetails(
                            firstname: widget.firstname,
                            lastname: widget.lastname,
                            email: widget.email,
                            phone: widget.phone,
                            address: widget.address,
                            slmc: widget.slmc,
                            speciality: widget.speciality,
                            university: widget.university,
                            qualify: widget.qualify,
                            consult: widget.consult,
                            uid: widget.uid,
                            profession: widget.profession,
                            isPgimCertified: widget.isPgimCertified,
                            file1: file1,
                            file2: file2,
                            file3: file3,
                            file4: file4,
                            file5: file5,
                            file6: file6),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: secondaryColor,
                        content: Text(
                          "Select all documents",
                          style: TextStyle(
                            fontFamily: 'InterMedium',
                            color: Colors.white,
                          ),
                        )));
                  }
                },
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0))),
                  backgroundColor: MaterialStateProperty.all(Colors.white),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      'Next',
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
            const Expanded(
                child: SizedBox(
              height: 0,
            )),
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
        ]));
  }

  Future selectFile1() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg']);
    if (result == null) {
      return;
    } else {
      file1IsValid = true;
    }

    final path = result.files.single.path!;

    setState(() => file1 = io.File(path));
  }

  Future selectFile2() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg']);

    if (result == null) {
      return;
    } else {
      file2IsValid = true;
    }

    final path = result.files.single.path!;

    setState(() => file2 = io.File(path));
  }

  Future selectFile3() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg']);

    if (result == null) {
      return;
    } else {
      file3IsValid = true;
    }
    final path = result.files.single.path!;

    setState(() => file3 = io.File(path));
  }

  Future selectFile4() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg']);

    if (result == null) {
      return;
    } else {
      file4IsValid = true;
    }

    final path = result.files.single.path!;

    setState(() => file4 = io.File(path));
  }

  Future selectFile5() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'png', 'jpeg']);

    if (result == null) {
      return;
    } else {
      file5IsValid = true;
    }

    final path = result.files.single.path!;

    setState(() => file5 = io.File(path));
  }

  Future selectFile6() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png', 'jpeg']);

    if (result == null) {
      return;
    } else {
      file6IsValid = true;
    }

    final path = result.files.single.path!;

    setState(() => file6 = io.File(path));
  }
}
