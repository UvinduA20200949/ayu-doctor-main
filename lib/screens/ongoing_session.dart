import 'dart:developer';

import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/models/session.dart';
import 'package:ayu_doctor/models/user.dart' as u;
import 'package:ayu_doctor/provider/doctor_provider.dart';
import 'package:ayu_doctor/utils/call_utilities.dart';
import 'package:ayu_doctor/utils/permissions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ayu_doctor/utils/colors.dart';
import 'package:provider/provider.dart';

class Ongoing extends StatefulWidget {
  const Ongoing({Key? key}) : super(key: key);

  @override
  State<Ongoing> createState() => _OngoingState();
}

class _OngoingState extends State<Ongoing> {
  String today = '';

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    today = DateFormat.yMMMd().format(now);
  }

  @override
  Widget build(BuildContext context) {
    final DoctorProvider doctorProvider = Provider.of<DoctorProvider>(context);
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(children: [
            Container(
              height: _height * 0.2,
              width: _width,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              margin: const EdgeInsets.only(bottom: 40),
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [quaternaryColor, primaryColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    stops: [0.3, 1],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  )),
              child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: constraints.maxWidth * 0.07,
                              height: constraints.maxWidth * 0.07,
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.white),
                              child: const Icon(
                                Icons.arrow_back_ios_new_outlined,
                                size: 17,
                                color: quaternaryColor,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Ongoing',
                                  style: TextStyle(
                                    fontFamily: 'InterBold',
                                    fontSize: 27,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
            ),
            Positioned(
              top: _height * 0.08,
              left: _width * 0.65,
              child: Container(
                height: _height * 0.2,
                width: _width * 0.3,
                decoration: const BoxDecoration(
                  // shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage('assets/images/Medicine_amicoe.png'),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ]),
          Flexible(
              child: LayoutBuilder(
                  builder: ((context, constraints) => StreamBuilder<
                          List<Session>>(
                      stream:
                          readSessions(FirebaseAuth.instance.currentUser!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return AlertDialog(
                            title: const Text(
                              'Error',
                              style: TextStyle(color: secondaryColor),
                            ),
                            content: Text(
                              snapshot.error.toString(),
                              style: const TextStyle(color: secondaryText),
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(
                                24.0, 20.0, 24.0, 20.0),
                            backgroundColor: Colors.white,
                            actions: const [],
                          );
                        } else if (snapshot.hasData) {
                          final sessions = snapshot.data!;

                          return ListView.builder(
                              scrollDirection: Axis.vertical,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              itemCount: sessions.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (sessions[index].date == today &&
                                    checkStatus(sessions[index].time) &&
                                    sessions[index].status == 'unavailable') {
                                  return FutureBuilder(
                                      future: getUserDetails(
                                          sessions[index].patientUid),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<u.User> snapshot) {
                                        if (!snapshot.hasData) {
                                          return Container();
                                        }

                                        u.User user = snapshot.data!;

                                        return buildAppointmentCards(
                                            constraints,
                                            sessions[index],
                                            user,
                                            doctorProvider.getDoctor!);
                                      });
                                } else {
                                  return Container();
                                }
                              });
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: secondaryColor,
                            ),
                          );
                        }
                      }))))
        ],
      ),
    );
  }

  bool checkStatus(String t) {
    final now = DateTime.now();

    DateTime startingTime = DateFormat("hh:mm a").parse(t);
    DateTime endingTime = startingTime.add(const Duration(minutes: 15));
    String currentTime = DateFormat("hh:mm a").format(now);
    DateTime formattedCurrentTime = DateFormat("hh:mm a").parse(currentTime);

    String formattedStartingTime = DateFormat("hh:mm a").format(startingTime);
    String formattedEndingTime = DateFormat("hh:mm a").format(endingTime);

    log('Start: $formattedStartingTime, End: $formattedEndingTime, now: $currentTime');

    if (formattedCurrentTime.isAfter(startingTime) &&
        formattedCurrentTime.isAfter(endingTime)) {
      return false;
    } else if (formattedCurrentTime.isBefore(startingTime) &&
        formattedCurrentTime.isBefore(endingTime)) {
      return false;
    } else if (formattedCurrentTime.isAfter(startingTime) &&
        formattedCurrentTime.isBefore(endingTime)) {
      return true;
    } else if (formattedCurrentTime.isAtSameMomentAs(startingTime)) {
      return true;
    } else {
      return false;
    }
  }

  Future<u.User> getUserDetails(String uid) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    var json = data.data() as Map;
    return u.User(
        name: json['name'],
        email: json['email'],
        gender: json['gender'],
        nic: json['nic'],
        phoneNumber: json['phone_number'],
        bloodType: json['blood_type'],
        dateOfBirth: _convertStamp(json['date_of_birth']),
        address: json['address'],
        age: json['age'] as int,
        uid: json['uid'],
        profilePictureUrl: json['profilePictureUrl']);
  }

  DateTime _convertStamp(Timestamp _stamp) {
    return Timestamp(_stamp.seconds, _stamp.nanoseconds).toDate();
  }

  Stream<List<Session>> readSessions(String uid) => FirebaseFirestore.instance
      .collection('doctors')
      .doc(uid)
      .collection('appointments')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Session.fromJson(doc.data())).toList());

  Widget buildAppointmentCards(
      BoxConstraints constraints, Session session, u.User user, Doctor doctor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      elevation: 8,
      shadowColor: iconBackgroundColor,
      margin: const EdgeInsets.only(bottom: 20),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        onTap: () async {
          await Permissions.cameraAndMicrophonePermissionsGranted()
              ? CallUtils.dial(from: doctor, to: user, context: context)
              : {};
        },
        child: Container(
          padding: const EdgeInsets.all(15),
          width: constraints.maxWidth,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerRight,
                  end: Alignment.bottomRight,
                  stops: [0.25, 1],
                  colors: [primaryColor, secondaryColor]),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    radius: 35,
                    child: ClipOval(
                      child: Image.network(
                        user.profilePictureUrl,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: constraints.maxWidth * 0.03,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: constraints.maxHeight * 0.035,
                      child: Text(
                        user.name,
                        style: const TextStyle(
                          fontFamily: 'InterBold',
                          fontSize: 17,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    const Text(
                      'Last counsult 09/12/21',
                      style: TextStyle(
                        fontFamily: 'InterMedium',
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
