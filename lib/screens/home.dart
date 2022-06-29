import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/provider/doctor_provider.dart';
import 'package:ayu_doctor/resources/firebase_repository.dart';
import 'package:ayu_doctor/screens/bank_account.dart';
import 'package:ayu_doctor/screens/consultation.dart';
import 'package:ayu_doctor/screens/earnings.dart';
import 'package:ayu_doctor/screens/menu.dart';
import 'package:ayu_doctor/screens/ongoing_consultant.dart';
import 'package:ayu_doctor/screens/schedule_online_time.dart';
import 'package:ayu_doctor/screens/webinar_session.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import '../utils/colors.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late DoctorProvider doctorProvider;
  bool isOnline = false;
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) {
      doctorProvider = Provider.of<DoctorProvider>(context, listen: false);
      doctorProvider.refreshDoctor();
    });
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      drawer: const Menu(),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: _height * 0.25,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.bottomRight,
                      colors: [primaryColor, secondaryColor]),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(45),
                    bottomRight: Radius.circular(45),
                  ),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: [
                          InkWell(
                            onTap: () => Scaffold.of(context).openDrawer(),
                            child: Container(
                              margin: const EdgeInsets.only(top: 35, left: 20),
                              child: const Icon(
                                Icons.menu,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: constraints.maxWidth * 0.54,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 35),
                            child: TextButton(
                                onPressed: () {
                                  isOnline ? setOffline() : setOnline();
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
                                              BorderRadius.circular(10.0))),
                                  backgroundColor: MaterialStateProperty.all(
                                      isOnline ? tertiaryColor : quinaryColor),
                                ),
                                child: Text(
                                  isOnline ? 'Online' : 'Offline',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontFamily: 'InterBold',
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.04,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const <Widget>[
                            Text(
                              'Hi Doctor !',
                              style: TextStyle(
                                fontFamily: 'InterBold',
                                fontSize: 26,
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
            ],
          ),
          Positioned(
            top: _height * 0.17,
            left: _width * 0.36,
            child: Stack(
              children: [
                StreamBuilder<Map<String, dynamic>?>(
                    stream: FirebaseFirestore.instance
                        .collection('doctors')
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .snapshots()
                        .map((event) => event.data()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        var data = Doctor.fromJson(snapshot.data!);
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(180),
                          child: Image.network(
                            data.profilePictureUrl,
                            alignment: Alignment.center,
                            width: _height * 0.14,
                            height: _height * 0.14,
                            fit: BoxFit.fill,
                          ),
                        );
                      }

                      return const CircularProgressIndicator(
                        color: secondaryColor,
                      );
                    })
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(
                left: 20,
                top: _height * 0.27,
                right: 20,
              ),
              child: GridView.count(
                mainAxisSpacing: 0.28,
                crossAxisSpacing: 0.28,
                crossAxisCount: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OngoingConsultant(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 2),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/stethoscope.png')),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          const Text(
                            'Ongoing\nConsultant',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Consultation(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 2),
                            child: Image(
                                image: AssetImage(
                                    'assets/images/time-machine.png')),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          const Text(
                            'Past\nConsultations',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ScheduleOnlineTime(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 2),
                            child: Image(
                                image: AssetImage('assets/images/clocks.png')),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          const Text(
                            'Schedule\nonline',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const EarningsScreen(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 20, right: 20, top: 2),
                            child: Image(
                                width: 85,
                                height: 85,
                                image: AssetImage('assets/images/dollar.png')),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          const Text(
                            'Earnings',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BankAccount(
                            doctorUid: doctorProvider.getDoctor!.uid,
                          ),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 2),
                            child: Image(
                                image: AssetImage('assets/images/bank.png')),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          const Text(
                            'Bank\nAccount',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WebinarSession(),
                        ),
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.all(20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      elevation: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 30, right: 30, top: 2),
                            child: Image(
                                image:
                                    AssetImage('assets/images/tesseract.png')),
                          ),
                          SizedBox(
                            height: _height * 0.01,
                          ),
                          const Text(
                            'Add Webinar\nSession',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'InterBold',
                              fontSize: 15,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  Future<Doctor> getDoctor() async {
    final FirebaseRepository _firebaseRepository = FirebaseRepository();
    Doctor doctor = await _firebaseRepository.getDoctorDetails();
    return doctor;
  }

  Future setOffline() async {
    setState(() {
      isOnline = false;
    });
    await FirebaseFirestore.instance
        .collection("doctors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"online": false});
  }

  Future setOnline() async {
    setState(() {
      isOnline = true;
    });
    await FirebaseFirestore.instance
        .collection("doctors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({"online": true});
  }
}
