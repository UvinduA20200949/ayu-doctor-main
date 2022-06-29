import 'package:ayu_doctor/models/session.dart';
import 'package:ayu_doctor/screens/schedule_online_addslots.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayu_doctor/utils/colors.dart';
import 'package:intl/intl.dart';

class ScheduleOnlineTime extends StatefulWidget {
  const ScheduleOnlineTime({Key? key}) : super(key: key);

  @override
  State<ScheduleOnlineTime> createState() => _ScheduleOnlineTimeState();
}

class _ScheduleOnlineTimeState extends State<ScheduleOnlineTime> {
  DateTime dateToday = DateTime.now();
  String formattedFromTimeMon = '09:00 AM';
  String formattedFromTimeTue = '09:00 AM';
  String formattedFromTimeWed = '09:00 AM';
  String formattedFromTimeThu = '09:00 AM';
  String formattedFromTimeFri = '09:00 AM';
  String formattedFromTimeSat = '09:00 AM';
  String formattedFromTimeSun = '09:00 AM';
  String formattedToTimeMon = '09:30 AM';
  String formattedToTimeTue = '09:30 AM';
  String formattedToTimeWed = '09:30 AM';
  String formattedToTimeThu = '09:30 AM';
  String formattedToTimeFri = '09:30 AM';
  String formattedToTimeSat = '09:30 AM';
  String formattedToTimeSun = '09:30 AM';
  String? slotsMon = '0';
  String? slotsTue = '0';
  String? slotsWed = '0';
  String? slotsThu = '0';
  String? slotsFri = '0';
  String? slotsSat = '0';
  String? slotsSun = '0';

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Stack(children: [
            Container(
              height: _height * 0.25,
              width: _width,
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
              margin: const EdgeInsets.only(bottom: 25),
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
                  builder: (context, constraints) => Row(
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
                          SizedBox(
                            width: _width * 0.4,
                          ),
                          Container(
                            alignment: Alignment.topRight,
                            child: Column(
                              children: const [
                                Text(
                                  'Schedule',
                                  style: TextStyle(
                                    fontFamily: 'InterBold',
                                    fontSize: 27,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Online Time',
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
              left: _width * 0.15,
              child: Container(
                height: _height * 0.17,
                width: _width * 0.32,
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
          const Text(
            'Please Fill Your Weekly Schedule',
            style: TextStyle(
              fontFamily: 'InterBold',
              fontSize: 17,
              color: quaternaryColor,
            ),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) => ListView(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  // Monday
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                            ),
                            header: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Monday',
                                    style: TextStyle(
                                        fontFamily: 'InterBold',
                                        color: Colors.white,
                                        fontSize: 22),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/down.png"),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dateText(DateTime.monday)),
                                StreamBuilder<List<Session>>(
                                    stream: readSessions(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Error',
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ),
                                          content: Text(
                                            snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: secondaryText),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  24.0, 20.0, 24.0, 20.0),
                                          backgroundColor: Colors.white,
                                          actions: const [],
                                        );
                                      } else if (snapshot.hasData) {
                                        final sessions = snapshot.data!;

                                        //sorting message list
                                        // sessions.sort(
                                        //     (a, b) => a..compareTo(b.date));

                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: sessions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (sessions[index].date ==
                                                  convertDateText(
                                                      DateTime.monday)) {
                                                return addedSlots(
                                                    sessions[index]);
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
                                    }),
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxWidth * 0.35,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSlotsDialog(
                                                    wDay: DateTime.monday,
                                                    onValueChanged:
                                                        (TimeOfDay from,
                                                            TimeOfDay to,
                                                            String? value) {
                                                      setState(() {
                                                        formattedFromTimeMon =
                                                            '${from.hourOfPeriod.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')} ${from.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        formattedToTimeMon =
                                                            '${to.hourOfPeriod.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')} ${to.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        value ??= 'null';
                                                        slotsMon = value;
                                                      });
                                                    }));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                senaryColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Slot',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  // Tuesday
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                            ),
                            header: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Tuesday',
                                    style: TextStyle(
                                        fontFamily: 'InterBold',
                                        color: Colors.white,
                                        fontSize: 22),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/down.png"),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dateText(DateTime.tuesday)),
                                StreamBuilder<List<Session>>(
                                    stream: readSessions(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Error',
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ),
                                          content: Text(
                                            snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: secondaryText),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  24.0, 20.0, 24.0, 20.0),
                                          backgroundColor: Colors.white,
                                          actions: const [],
                                        );
                                      } else if (snapshot.hasData) {
                                        final sessions = snapshot.data!;

                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: sessions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (sessions[index].date ==
                                                  convertDateText(
                                                      DateTime.tuesday)) {
                                                return addedSlots(
                                                    sessions[index]);
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
                                    }),
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxWidth * 0.35,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSlotsDialog(
                                                    wDay: DateTime.tuesday,
                                                    onValueChanged:
                                                        (TimeOfDay from,
                                                            TimeOfDay to,
                                                            String? value) {
                                                      setState(() {
                                                        formattedFromTimeTue =
                                                            '${from.hourOfPeriod.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')} ${from.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        formattedToTimeTue =
                                                            '${to.hourOfPeriod.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')} ${to.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        value ??= 'null';
                                                        slotsTue = value;
                                                      });
                                                    }));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                senaryColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Slot',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  // Wednesday
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                            ),
                            header: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Wednesday',
                                    style: TextStyle(
                                        fontFamily: 'InterBold',
                                        color: Colors.white,
                                        fontSize: 22),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/down.png"),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dateText(DateTime.wednesday)),
                                StreamBuilder<List<Session>>(
                                    stream: readSessions(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Error',
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ),
                                          content: Text(
                                            snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: secondaryText),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  24.0, 20.0, 24.0, 20.0),
                                          backgroundColor: Colors.white,
                                          actions: const [],
                                        );
                                      } else if (snapshot.hasData) {
                                        final sessions = snapshot.data!;

                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: sessions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (sessions[index].date ==
                                                  convertDateText(
                                                      DateTime.wednesday)) {
                                                return addedSlots(
                                                    sessions[index]);
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
                                    }),
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxWidth * 0.35,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSlotsDialog(
                                                    wDay: DateTime.wednesday,
                                                    onValueChanged:
                                                        (TimeOfDay from,
                                                            TimeOfDay to,
                                                            String? value) {
                                                      setState(() {
                                                        formattedFromTimeWed =
                                                            '${from.hourOfPeriod.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')} ${from.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        formattedToTimeWed =
                                                            '${to.hourOfPeriod.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')} ${to.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        value ??= 'null';
                                                        slotsWed = value;
                                                      });
                                                    }));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                senaryColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Slot',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  // Thursday
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                            ),
                            header: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Thursday',
                                    style: TextStyle(
                                        fontFamily: 'InterBold',
                                        color: Colors.white,
                                        fontSize: 22),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/down.png"),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dateText(DateTime.thursday)),
                                StreamBuilder<List<Session>>(
                                    stream: readSessions(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Error',
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ),
                                          content: Text(
                                            snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: secondaryText),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  24.0, 20.0, 24.0, 20.0),
                                          backgroundColor: Colors.white,
                                          actions: const [],
                                        );
                                      } else if (snapshot.hasData) {
                                        final sessions = snapshot.data!;

                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: sessions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (sessions[index].date ==
                                                  convertDateText(
                                                      DateTime.thursday)) {
                                                return addedSlots(
                                                    sessions[index]);
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
                                    }),
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxWidth * 0.35,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSlotsDialog(
                                                    wDay: DateTime.thursday,
                                                    onValueChanged:
                                                        (TimeOfDay from,
                                                            TimeOfDay to,
                                                            String? value) {
                                                      setState(() {
                                                        formattedFromTimeThu =
                                                            '${from.hourOfPeriod.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')} ${from.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        formattedToTimeThu =
                                                            '${to.hourOfPeriod.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')} ${to.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        value ??= 'null';
                                                        slotsThu = value;
                                                      });
                                                    }));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                senaryColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Slot',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  // Friday
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                            ),
                            header: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Friday',
                                    style: TextStyle(
                                        fontFamily: 'InterBold',
                                        color: Colors.white,
                                        fontSize: 22),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/down.png"),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dateText(DateTime.friday)),
                                StreamBuilder<List<Session>>(
                                    stream: readSessions(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Error',
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ),
                                          content: Text(
                                            snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: secondaryText),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  24.0, 20.0, 24.0, 20.0),
                                          backgroundColor: Colors.white,
                                          actions: const [],
                                        );
                                      } else if (snapshot.hasData) {
                                        final sessions = snapshot.data!;
                                        //sorting session list
                                        sessions.sort(
                                            (a, b) => a.time.compareTo(b.time));
                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: sessions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (sessions[index].date ==
                                                  convertDateText(
                                                      DateTime.friday)) {
                                                return addedSlots(
                                                    sessions[index]);
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
                                    }),
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxWidth * 0.35,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSlotsDialog(
                                                    wDay: DateTime.friday,
                                                    onValueChanged:
                                                        (TimeOfDay from,
                                                            TimeOfDay to,
                                                            String? value) {
                                                      setState(() {
                                                        formattedFromTimeFri =
                                                            '${from.hourOfPeriod.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')} ${from.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        formattedToTimeFri =
                                                            '${to.hourOfPeriod.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')} ${to.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        value ??= 'null';
                                                        slotsFri = value;
                                                      });
                                                    }));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                senaryColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Slot',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  // Saturday
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                            ),
                            header: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Saturday',
                                    style: TextStyle(
                                        fontFamily: 'InterBold',
                                        color: Colors.white,
                                        fontSize: 22),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/down.png"),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dateText(DateTime.saturday)),
                                StreamBuilder<List<Session>>(
                                    stream: readSessions(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Error',
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ),
                                          content: Text(
                                            snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: secondaryText),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  24.0, 20.0, 24.0, 20.0),
                                          backgroundColor: Colors.white,
                                          actions: const [],
                                        );
                                      } else if (snapshot.hasData) {
                                        final sessions = snapshot.data!;

                                        return ListView.builder(
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: sessions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (sessions[index].date ==
                                                  convertDateText(
                                                      DateTime.saturday)) {
                                                return addedSlots(
                                                    sessions[index]);
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
                                    }),
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxWidth * 0.35,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSlotsDialog(
                                                    wDay: DateTime.saturday,
                                                    onValueChanged:
                                                        (TimeOfDay from,
                                                            TimeOfDay to,
                                                            String? value) {
                                                      setState(() {
                                                        formattedFromTimeSat =
                                                            '${from.hourOfPeriod.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')} ${from.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        formattedToTimeSat =
                                                            '${to.hourOfPeriod.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')} ${to.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        value ??= 'null';
                                                        slotsSat = value;
                                                      });
                                                    }));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                senaryColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Slot',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                  // Sunday
                  Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    elevation: 0,
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        width: constraints.maxWidth,
                        decoration: const BoxDecoration(
                            color: Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Center(
                          child: ExpandablePanel(
                            theme: const ExpandableThemeData(
                              hasIcon: false,
                            ),
                            header: Container(
                              alignment: Alignment.center,
                              decoration: const BoxDecoration(
                                  color: primaryColor,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              height: constraints.maxHeight * 0.12,
                              width: constraints.maxWidth,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const <Widget>[
                                  Text(
                                    'Sunday',
                                    style: TextStyle(
                                        fontFamily: 'InterBold',
                                        color: Colors.white,
                                        fontSize: 22),
                                  ),
                                  ImageIcon(
                                    AssetImage("assets/icons/down.png"),
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                            collapsed: Container(),
                            expanded: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 15),
                                    child: dateText(DateTime.sunday)),
                                StreamBuilder<List<Session>>(
                                    stream: readSessions(
                                        FirebaseAuth.instance.currentUser!.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          title: const Text(
                                            'Error',
                                            style: TextStyle(
                                                color: secondaryColor),
                                          ),
                                          content: Text(
                                            snapshot.error.toString(),
                                            style: const TextStyle(
                                                color: secondaryText),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  24.0, 20.0, 24.0, 20.0),
                                          backgroundColor: Colors.white,
                                          actions: const [],
                                        );
                                      } else if (snapshot.hasData) {
                                        final sessions = snapshot.data!;

                                        return ListView.builder(
                                            // physics:
                                            //     NeverScrollableScrollPhysics(),
                                            scrollDirection: Axis.vertical,
                                            shrinkWrap: true,
                                            padding: const EdgeInsets.all(0),
                                            itemCount: sessions.length,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              if (sessions[index].date ==
                                                  convertDateText(
                                                      DateTime.sunday)) {
                                                return addedSlots(
                                                    sessions[index]);
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
                                    }),
                                Container(
                                  margin: const EdgeInsets.only(top: 30),
                                  height: constraints.maxHeight * 0.08,
                                  width: constraints.maxWidth * 0.35,
                                  child: TextButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) =>
                                                AddSlotsDialog(
                                                    wDay: DateTime.sunday,
                                                    onValueChanged:
                                                        (TimeOfDay from,
                                                            TimeOfDay to,
                                                            String? value) {
                                                      setState(() {
                                                        formattedFromTimeSun =
                                                            '${from.hourOfPeriod.toString().padLeft(2, '0')}:${from.minute.toString().padLeft(2, '0')} ${from.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        formattedToTimeSun =
                                                            '${to.hourOfPeriod.toString().padLeft(2, '0')}:${to.minute.toString().padLeft(2, '0')} ${to.period.toString().substring(10)}'
                                                                .toUpperCase();
                                                        value ??= 'null';
                                                        slotsSun = value;
                                                      });
                                                    }));
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                senaryColor),
                                      ),
                                      child: const Center(
                                        child: Text(
                                          'Add Slot',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontFamily: 'InterBold',
                                          ),
                                        ),
                                      )),
                                ),
                              ],
                            ),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24,
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  Stream<List<Session>> readSessions(String uid) => FirebaseFirestore.instance
      .collection('doctors')
      .doc(uid)
      .collection('appointments')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Session.fromJson(doc.data())).toList());

  Widget addedSlots(Session session) {
    TimeOfDay startTime = fromString(session.time);
    final now = DateTime.now();
    DateTime date = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    TimeOfDay endTime =
        TimeOfDay.fromDateTime(date.add(const Duration(minutes: 30)));
    String formattedEndTime =
        '${endTime.hourOfPeriod.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')} ${endTime.period.toString().substring(10)}'
            .toUpperCase();

    return Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.fromLTRB(25, 0, 25, 10),
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.2),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        child: Center(
          child: Text(
            '${session.time} - $formattedEndTime',
            style: const TextStyle(
              fontFamily: 'InterBold',
              fontSize: 15,
              color: primaryText,
            ),
          ),
        ));
  }

  String convertDateText(int wDay) {
    String date;
    DateTime today = DateTime.now();
    DateTime firstDayOfTheweek =
        today.subtract(Duration(days: today.weekday - 7 - 1));

    if (wDay < dateToday.weekday) {
      if (wDay == 1) {
        date = firstDayOfTheweek.toString().substring(0, 10);
      } else if (wDay == 2) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 1));
        date = i.toString().substring(0, 10);
      } else if (wDay == 3) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 2));
        date = i.toString().substring(0, 10);
      } else if (wDay == 4) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 3));
        date = i.toString().substring(0, 10);
      } else if (wDay == 5) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 4));
        date = i.toString().substring(0, 10);
      } else if (wDay == 6) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 5));
        date = i.toString().substring(0, 10);
      } else {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 6));
        date = i.toString().substring(0, 10);
      }
    } else {
      date = dateToday
          .subtract(Duration(days: dateToday.weekday - wDay))
          .toString();
    }

    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat.yMMMd().format(inputDate);

    return outputDate;
  }

  Widget dateText(int wDay) {
    String date;
    DateTime today = DateTime.now();
    DateTime firstDayOfTheweek =
        today.subtract(Duration(days: today.weekday - 7 - 1));

    if (wDay < dateToday.weekday) {
      if (wDay == 1) {
        date = firstDayOfTheweek.toString().substring(0, 10);
      } else if (wDay == 2) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 1));
        date = i.toString().substring(0, 10);
      } else if (wDay == 3) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 2));
        date = i.toString().substring(0, 10);
      } else if (wDay == 4) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 3));
        date = i.toString().substring(0, 10);
      } else if (wDay == 5) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 4));
        date = i.toString().substring(0, 10);
      } else if (wDay == 6) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 5));
        date = i.toString().substring(0, 10);
      } else {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 6));
        date = i.toString().substring(0, 10);
      }
      // date = dateToday
      //     .add(Duration(days: dateToday.weekday + wDay))
      //     .toString()
      //     .substring(0, 10);
    } else {
      date = dateToday
          .subtract(Duration(days: dateToday.weekday - wDay))
          .toString()
          .substring(0, 10);
    }

    //log('$wDay : $date');

    return Text(
      date,
      style: const TextStyle(
        fontFamily: 'InterBold',
        fontSize: 20,
        color: quinaryColor,
      ),
    );
  }
}
