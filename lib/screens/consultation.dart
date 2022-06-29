import 'dart:developer';

import 'package:ayu_doctor/models/patient.dart';
import 'package:ayu_doctor/models/session.dart';
import 'package:ayu_doctor/models/user.dart' as u;
import 'package:ayu_doctor/screens/chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:intl/intl.dart';

class Consultation extends StatefulWidget {
  const Consultation({Key? key}) : super(key: key);

  @override
  _Consultation createState() => _Consultation();
}

class _Consultation extends State<Consultation> {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <
          Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
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
                              'Consultations',
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
        Flexible(
            child: LayoutBuilder(
                builder: (context, constraints) => StreamBuilder<List<Session>>(
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
                          contentPadding:
                              const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 20.0),
                          backgroundColor: Colors.white,
                          actions: const [],
                        );
                      } else if (snapshot.hasData) {
                        final sessions = snapshot.data!;

                        return ListView.builder(
                            scrollDirection: Axis.vertical,
                            padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                            itemCount: sessions.length,
                            itemBuilder: (BuildContext context, int index) {
                              if (sessions[index].status == 'unavailable' &&
                                  checkStatus(sessions[index].date,
                                      sessions[index].time)) {
                                return FutureBuilder(
                                    future: getUserDetails(
                                        sessions[index].patientUid),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<Patient> snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }

                                      Patient user = snapshot.data!;

                                      return buildAppointmentCards(
                                          constraints, sessions[index], user);
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
                    })))
      ]),
    );
  }

  bool checkStatus(String d, String t) {
    final now = DateTime.now();
    String formattedNow = DateFormat.yMMMd().format(now);
    final date = DateFormat.yMMMd().parse(d);
    String formattedDate = DateFormat.yMMMd().format(date);

    log('Now: $formattedNow Date: $formattedDate');

    if (now.isAfter(date)) {
      return true;
    } else if (formattedNow == formattedDate) {
      if (checkTimeStatus(t)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool checkTimeStatus(String t) {
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
      return true;
    } else {
      return false;
    }
  }

  Future<Patient> getUserDetails(String uid) async {
    DocumentSnapshot data =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    var json = data.data() as Map;
    return Patient(
        name: json['name'],
        email: json['email'],
        gender: json['gender'],
        nic: json['nic'],
        phoneNumber: json['phone_number'],
        bloodType: json['blood_type'],
        dateOfBirth: json['date_of_birth'],
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
      BoxConstraints constraints, Session session, Patient user) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.0),
      ),
      elevation: 5,
      shadowColor: iconBackgroundColor,
      margin: const EdgeInsets.only(bottom: 20),
      child: Container(
          padding: const EdgeInsets.all(15),
          width: constraints.maxWidth,
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  stops: [0.2, 1],
                  colors: [primaryColor, secondaryColor]),
              borderRadius: BorderRadius.all(Radius.circular(40))),
          child: ExpandablePanel(
            theme: const ExpandableThemeData(iconColor: Colors.transparent),
            header: Row(
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
                        'Last counsult 09/12/22',
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
            collapsed: Container(),
            expanded: Column(
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.002,
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 15, bottom: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.04,
                          width: constraints.maxHeight * 0.04,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/records.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        const Text(
                          'Records',
                          style: TextStyle(
                            fontFamily: 'InterBold',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Chat(
                                    patient: user,
                                  ))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            height: constraints.maxHeight * 0.04,
                            width: constraints.maxHeight * 0.04,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/icons/chat.png'),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          const Text(
                            'Chat Feed',
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: constraints.maxHeight * 0.04,
                          width: constraints.maxHeight * 0.04,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/icons/history.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: constraints.maxHeight * 0.01,
                        ),
                        const Text(
                          'History',
                          style: TextStyle(
                            fontFamily: 'InterBold',
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
