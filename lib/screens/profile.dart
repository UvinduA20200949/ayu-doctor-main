import 'dart:developer';
import 'dart:io';

import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/screens/menu.dart';
import 'package:ayu_doctor/widgets/change_address_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart' as storage;

class Profile extends StatefulWidget {
  final String userID;
  const Profile({Key? key, required this.userID}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController newTextController = TextEditingController();
  bool isUploading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            StreamBuilder<Map<String, dynamic>?>(
                stream: FirebaseFirestore.instance
                    .collection('doctors')
                    .doc(widget.userID)
                    .snapshots()
                    .map((event) => event.data()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var data = Doctor.fromJson(snapshot.data!);

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: _height * 0.25,
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
                                Container(
                                  margin: const EdgeInsets.only(top: 40),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: const <Widget>[],
                                  ),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Container(
                                    margin:
                                        const EdgeInsets.only(left: 20, top: 5),
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
                                SizedBox(
                                  height: constraints.maxHeight * 0.02,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        data.profession == 'doctor'
                                            ? 'Dr.  ${data.name}'
                                            : 'Prof.  ${data.name}',
                                        style: const TextStyle(
                                          fontFamily: 'InterBold',
                                          fontSize: 24,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        height: constraints.maxHeight * 0.02,
                                      ),
                                      // const Text(
                                      //   'Member since Jan 31 2022',
                                      //   style: TextStyle(
                                      //     fontFamily: 'InterBold',
                                      //     fontSize: 15,
                                      //     color: Colors.white,
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.11,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: iconBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            width: _width,
                            child: Row(children: [
                              const Expanded(
                                child: Text("E-mail",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'InterMedium',
                                        color: secondaryText)),
                                flex: 3,
                              ),
                              Expanded(
                                child: Text(
                                  data.email,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'InterMedium',
                                      color: primaryText),
                                ),
                                flex: 8,
                              ),
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      slmcUpdate(
                                          context,
                                          _width,
                                          _height,
                                          "Change E-mail",
                                          "New E-mail",
                                          newTextController, () {
                                        newEmailUpdate(
                                            newTextController.text, context);
                                      }).then((_) {
                                        newTextController.clear();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: primaryText,
                                    )),
                                flex: 1,
                              )
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: iconBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            width: _width,
                            child: Row(children: [
                              const Expanded(
                                child: Text("Mobile",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'InterMedium',
                                        color: secondaryText)),
                                flex: 3,
                              ),
                              Expanded(
                                child: Text(
                                  data.phoneNumber,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'InterMedium',
                                      color: primaryText),
                                ),
                                flex: 9,
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: iconBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            width: _width,
                            child: Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceAround,
                                children: [
                                  const Expanded(
                                    child: Text("Address",
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'InterMedium',
                                            color: secondaryText)),
                                    flex: 3,
                                  ),
                                  const Expanded(
                                    child: Text(
                                      "325/c1, 1st cross street, colombom, sri lanka",
                                      style: TextStyle(
                                          fontSize: 17,
                                          fontFamily: 'InterMedium',
                                          color: primaryText),
                                    ),
                                    flex: 8,
                                  ),
                                  Expanded(
                                    child: InkWell(
                                        onTap: () {
                                          showChangeAddressDialog(context);
                                        },
                                        child: const Icon(
                                          Icons.edit,
                                          color: primaryText,
                                        )),
                                    flex: 1,
                                  )
                                ]),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: iconBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            width: _width,
                            child: Row(children: [
                              const Expanded(
                                child: Text("Medical Schools",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'InterMedium',
                                        color: secondaryText)),
                                flex: 3,
                              ),
                              Expanded(
                                child: Text(
                                  data.medicalSchool,
                                  textAlign: TextAlign.end,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'InterMedium',
                                      color: primaryText),
                                ),
                                // flex: 2,
                              ),
                              Expanded(
                                child: Container(),
                                flex: 2,
                              )
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: iconBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            width: _width,
                            child: Row(children: [
                              const Expanded(
                                child: Text("SLMC",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'InterMedium',
                                        color: secondaryText)),
                                flex: 6,
                              ),
                              Expanded(
                                child: Text(
                                  data.slmc,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'InterMedium',
                                      color: primaryText),
                                ),
                                flex: 6,
                              ),
                              Expanded(
                                child: InkWell(
                                    onTap: () {
                                      slmcUpdate(
                                          context,
                                          _width,
                                          _height,
                                          "Change SLMC",
                                          "New SLMC",
                                          newTextController, () {
                                        newSlmcUpdate(
                                            newTextController.text, context);
                                      }).then((_) {
                                        newTextController.clear();
                                      });
                                    },
                                    child: const Icon(
                                      Icons.edit,
                                      color: primaryText,
                                    )),
                                flex: 1,
                              )
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: iconBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            width: _width,
                            child: Row(children: [
                              const Expanded(
                                child: Text("Profession",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'InterMedium',
                                        color: secondaryText)),
                                flex: 6,
                              ),
                              Expanded(
                                child: Text(
                                  data.profession,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'InterMedium',
                                      color: primaryText),
                                ),
                                flex: 6,
                              ),
                            ]),
                          ),
                        ),
                        SizedBox(
                          height: _height * 0.015,
                        ),
                        Card(
                          elevation: 5,
                          shadowColor: iconBackgroundColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(15),
                            width: _width,
                            child: Row(children: [
                              const Expanded(
                                child: Text("Preferred Languages",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'InterMedium',
                                        color: secondaryText)),
                                flex: 8,
                              ),
                              const Expanded(
                                child: Text(
                                  "English",
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontFamily: 'InterMedium',
                                      color: primaryText),
                                ),
                                flex: 3,
                              ),
                              Expanded(
                                child: InkWell(
                                    onTap: () {},
                                    child: const Icon(
                                      Icons.edit,
                                      color: primaryText,
                                    )),
                                flex: 1,
                              )
                            ]),
                          ),
                        ),
                      ],
                    );
                  }

                  return const CircularProgressIndicator();
                }),
            Positioned(
              top: _height * 0.16,
              left: _width * 0.33,
              child: Stack(
                children: [
                  StreamBuilder<Map<String, dynamic>?>(
                      stream: FirebaseFirestore.instance
                          .collection('doctors')
                          .doc(widget.userID)
                          .snapshots()
                          .map((event) => event.data()),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          var data = Doctor.fromJson(snapshot.data!);
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(180),
                            child: isUploading
                                ? const Center(
                                    child: CircularProgressIndicator(
                                      color: secondaryColor,
                                    ),
                                  )
                                : Image.network(
                                    data.profilePictureUrl,
                                    alignment: Alignment.center,
                                    width: _height * 0.17,
                                    height: _height * 0.17,
                                    fit: BoxFit.fill,
                                  ),
                          );
                        }

                        return const CircularProgressIndicator(
                          color: secondaryColor,
                        );
                      }),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () => _selectPhoto(),
                      child: const CircleAvatar(
                        backgroundColor: primaryColor,
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _selectPhoto() async {
    await showModalBottomSheet(
        context: context,
        builder: (context) => BottomSheet(
            onClosing: () {},
            builder: (context) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.camera_alt_rounded,
                        color: primaryColor,
                      ),
                      title: const Text(
                        'Camera',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontFamily: 'InterMedium',
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.camera);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.filter,
                        color: primaryColor,
                      ),
                      title: const Text(
                        'Pick a file',
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 15,
                          fontFamily: 'InterMedium',
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        _pickImage(ImageSource.gallery);
                      },
                    ),
                  ],
                )));
  }

  Future _pickImage(ImageSource gallery) async {
    final pickedFile =
        await _picker.pickImage(source: gallery, imageQuality: 50);
    if (pickedFile == null) {
      return;
    }

    var file = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1));
    if (file == null) {
      return;
    }
    file = (await compressImage(file.path, 35)) as CroppedFile?;
    await _uploadFile(file!.path);
  }

  Future<File> compressImage(String path, int quality) async {
    final newPath = p.join((await getTemporaryDirectory()).path,
        '${DateTime.now()}.${p.extension(path)}');

    final result = await FlutterImageCompress.compressAndGetFile(path, newPath,
        quality: quality);

    return result!;
  }

  Future _uploadFile(String path) async {
    setState(() {
      isUploading = true;
      log('Log: ProfilePicture - Uploading ...');
    });
    try {
      final ref = storage.FirebaseStorage.instance
          .ref()
          .child('doctors_profile_pictures')
          .child(userId)
          .child(DateTime.now().toIso8601String() + p.basename(path));

      final result = await ref.putFile(File(path));
      setState(() {});
      final fileUrl = await result.ref.getDownloadURL();

      updateProfilePictureFirebase(fileUrl);

      setState(() {
        isUploading = false;
        log('Log: ProfilePicture - Image URL = $fileUrl');
      });
    } on Exception catch (e) {
      return AlertDialog(
        title: const Text(
          'Error',
          style: TextStyle(color: secondaryColor),
        ),
        content: Text(
          e.toString(),
          style: const TextStyle(color: secondaryText),
        ),
        contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
        backgroundColor: Colors.white,
        actions: const [],
      );
    }
  }

  Future updateProfilePictureFirebase(String path) async {
    await FirebaseFirestore.instance
        .collection("doctors")
        .doc(userId)
        .update({"profile_picture_url": path});
  }

  Future<dynamic> slmcUpdate(
      BuildContext context,
      double _width,
      double _height,
      String dialogBoxText,
      String textFieldText,
      TextEditingController control,
      Function onTapFunc) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            alignment: Alignment.center,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            child: Container(
              width: _width * 0.9,
              height: _height * 0.3,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(35.0),
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Text(
                      dialogBoxText,
                      style: const TextStyle(
                          fontSize: 17,
                          fontFamily: 'InterMedium',
                          color: primaryText),
                    ),

                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.1),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: TextField(
                        controller: control,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: primaryText,
                            fontFamily: 'InterMedium',
                            fontSize: 15),
                        decoration: InputDecoration(
                          hintText: textFieldText,
                          hintStyle: const TextStyle(
                            fontFamily: 'InterMedium',
                            color: secondaryText,
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: secondaryColor,
                        maxLines: 1,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    SizedBox(
                      width: _width / 3,
                      child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0))),
                            backgroundColor:
                                MaterialStateProperty.all(secondaryColor),
                          ),
                          onPressed: () {
                            if (control.text.isNotEmpty || control.text != "") {
                              onTapFunc();
                            } else {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      content:
                                          Text("Please input $textFieldText "),
                                    );
                                  });
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Update',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'InterBold',
                                ),
                              ),
                              // SizedBox(
                              //   width: constraints
                              //           .maxWidth *
                              //       0.02,
                              // ),
                              Icon(
                                Icons.arrow_forward_rounded,
                                color: Colors.white,
                              )
                            ],
                          )),
                    ),
                  ]),
            ),
          );
        });
  }

  Future<void> newSlmcUpdate(String newSLMC, BuildContext context) async {
    // ignore: await_only_futures
    var currentUser = await FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(currentUser)
          .update({"slmc": newSLMC}).then((value) => {
                // showDialog(
                //   context: context,
                //   builder: (context) => const AlertDialog(
                //     content: Text("Done !"),
                //   ),
                // ),
                Navigator.pop(context)
              });
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message!),
        ),
      );
      // debugPrint(e.message);
    }
  }

  Future<void> newEmailUpdate(String newEmail, BuildContext context) async {
    // ignore: await_only_futures
    var currentUser = await FirebaseAuth.instance.currentUser!.uid;
    try {
      await FirebaseFirestore.instance
          .collection("doctors")
          .doc(currentUser)
          .update({"email": newEmail}).then((value) => {
                // showDialog(
                //   context: context,
                //   builder: (context) => const AlertDialog(
                //     content: Text("Done !"),
                //   ),
                // ),
                Navigator.pop(context)
              });
    } on FirebaseException catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Text(e.message!),
        ),
      );
      // debugPrint(e.message);
    }
  }
}
