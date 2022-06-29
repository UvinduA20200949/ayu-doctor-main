import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/resources/firebase_repository.dart';
import 'package:ayu_doctor/screens/bookings.dart';
import 'package:ayu_doctor/screens/complain_and_feedback.dart';
import 'package:ayu_doctor/screens/contact_us.dart';
import 'package:ayu_doctor/screens/profile.dart';
import 'package:ayu_doctor/screens/sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

// User currentUser = await  FirebaseMethods().getCurrentUser();
var userId = FirebaseAuth.instance.currentUser!.uid;

class Menu extends StatelessWidget {
  // final Doctor doctor;
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              height: _height * 0.44,
              width: 100,
              color: primaryColor,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: StreamBuilder<Map<String, dynamic>?>(
                    stream: FirebaseFirestore.instance
                        .collection('doctors')
                        .doc(userId)
                        .snapshots()
                        .map((event) => event.data()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = Doctor.fromJson(snapshot.data!);
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  data.profilePictureUrl,
                                  alignment: Alignment.center,
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                  data.profession == 'doctor'
                                      ? 'Dr. ${data.name}'
                                      : 'Prof. ${data.name}',
                                  style: const TextStyle(
                                    fontFamily: 'InterBold',
                                    fontSize: 20,
                                    color: Colors.white,
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Profile(
                                          userID: userId,
                                        ),
                                      ),
                                    );
                                  },
                                  style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                      const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                    ),
                                    shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        secondaryColor),
                                  ),
                                  child: const Text(
                                    'Edit profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'InterBold',
                                    ),
                                  )),
                            ),
                          ],
                        );
                      }
                      // if (!snapshot.hasData) {
                      //   return Text(snapshot.data!.isEmpty.toString());
                      // }
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              'assets/images/profile_picture.jpg',
                              alignment: Alignment.center,
                              width: 100,
                              height: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 20),
                            child: Text('Dr.Shehan Sumanathilaka',
                                style: TextStyle(
                                  fontFamily: 'InterBold',
                                  fontSize: 20,
                                  color: Colors.white,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Profile(
                                        userID: userId,
                                      ),
                                    ),
                                  );
                                },
                                style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                    const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  ),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0))),
                                  backgroundColor:
                                      MaterialStateProperty.all(secondaryColor),
                                ),
                                child: const Text(
                                  'Edit profile',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'InterBold',
                                  ),
                                )),
                          ),
                        ],
                      );
                    }),
              ),
            ),
          ),
          ListTile(
            title: const Text('Booking',
                style: TextStyle(
                  fontFamily: 'InterBold',
                  fontSize: 17,
                  color: primaryText,
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Bookings()));
            },
          ),
          ListTile(
              title: const Text('Complain & Feedback',
                  style: TextStyle(
                    fontFamily: 'InterBold',
                    fontSize: 17,
                    color: primaryText,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ComplainAndFeedback(),
                  ),
                );
              }),
          ListTile(
              title: const Text('Contact Us',
                  style: TextStyle(
                    fontFamily: 'InterBold',
                    fontSize: 17,
                    color: primaryText,
                  )),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ContactUs(),
                  ),
                );
              }),
          ListTile(
              title: const Text('Log out',
                  style: TextStyle(
                    fontFamily: 'InterBold',
                    fontSize: 17,
                    color: primaryText,
                  )),
              onTap: () {
                showDialogWidget(context);
              }),
          Center(
            child: Container(
              height: _height * 0.15,
              margin: const EdgeInsets.only(top: 50),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/app_icon.png'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            height: _height * 0.05,
          ),
          SizedBox(
            height: _height * 0.035,
          ),
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 100);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}

Future<Doctor> getDoctor() async {
  final FirebaseRepository _firebaseRepository = FirebaseRepository();
  // ignore: unnecessary_cast
  Doctor doctor = (await _firebaseRepository.getDoctorDetails()) as Doctor;
  return doctor;
}

showDialogWidget(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: const Text("Confirmation"),
    content: const Text('Are you sure you want to Logout?'),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text("No"),
      ),
      TextButton(
        onPressed: () async {
          await FirebaseAuth.instance.signOut();
          Navigator.pushAndRemoveUntil<dynamic>(
            context,
            MaterialPageRoute<dynamic>(
              builder: (BuildContext context) => const SignIn(),
            ),
            (route) => false,
          );
        },
        child: const Text("Yes"),
      ),
    ],
  );
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      });
}
