import 'dart:math';

import 'package:ayu_doctor/models/session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../utils/colors.dart';
import 'package:intl/intl.dart';

class EarningsScreen extends StatefulWidget {
  const EarningsScreen({Key? key}) : super(key: key);

  @override
  _EarningsScreen createState() => _EarningsScreen();
}

final currentDoctor = FirebaseAuth.instance.currentUser;

class _EarningsScreen extends State<EarningsScreen> {
  var totalEarning = 0.0;
  var numberFormat = NumberFormat('##0.00', 'en_US');
  double totalEarnings(List<Session> list) {
    totalEarning = 0.0;

    for (var element in list) {
      totalEarning += element.fee;
    }
    double totalEarning2 = roundDouble(totalEarning, 2);
    return totalEarning2;
  }

  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
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
                            'Earnings',
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
                ),
              ),
            ),
            Flexible(
              child: LayoutBuilder(
                builder: (context, constraints) => StreamBuilder<List<Session>>(
                  stream: getEarningsFromAppointments(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      totalEarning = 0.0;
                      final earningList = snapshot.data!;

                      //sorting message list
                      earningList.sort((a, b) => a.date.compareTo(b.date));

                      return SingleChildScrollView(
                        physics: const ScrollPhysics(),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Text(
                                        'This Week',
                                        style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 8.0,
                                      ),
                                      Text(
                                        numberFormat
                                            .format(totalEarnings(earningList)),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 34,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ListView.builder(
                              itemCount: earningList.length,
                              padding:
                                  const EdgeInsets.fromLTRB(10, 20, 10, 20),
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              // scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return SingleEarningWidget(
                                    constraints: constraints,
                                    session: earningList[index]);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                    if (!snapshot.hasData) {
                      return const Text("No Data have");
                    }
                    if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            ),
          ]),
    );
  }
}

Stream<List<Session>> getEarningsFromAppointments() {
  final appointments = FirebaseFirestore.instance
      .collection('doctors')
      .doc(currentDoctor!.uid)
      .collection("appointments")
      .where("patient_uid", isNotEqualTo: "")
      .snapshots()
      .map((event) =>
          event.docs.map((e) => Session.fromJson(e.data())).toList());

  return appointments;
}

class SingleEarningWidget extends StatelessWidget {
  final Session session;
  final BoxConstraints constraints;
  const SingleEarningWidget({
    Key? key,
    required this.constraints,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
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
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(
          children: <Widget>[
            // Stack(
            //   children: <Widget>[
            //     Container(
            //       height: constraints.maxWidth * 0.15,
            //       width: constraints.maxWidth * 0.2,
            //       decoration: const BoxDecoration(
            //         shape: BoxShape.circle,
            //         color: iconBackgroundColor,
            //         image: DecorationImage(
            //           image: AssetImage('assets/images/doctor_male.png'),
            //           fit: BoxFit.contain,
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
            SizedBox(
              width: constraints.maxWidth * 0.03,
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    // height: constraints.maxHeight * 0.03,
                    child: Text(
                      session.firstName,
                      style: const TextStyle(
                        fontFamily: 'InterBold',
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.01,
                  ),
                  Text(
                    session.date,
                    style: const TextStyle(
                      fontFamily: 'InterMedium',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Text(
                "Rs. ${session.fee.toString()}",
                style: const TextStyle(
                  fontFamily: 'InterBold',
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
