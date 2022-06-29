import 'package:ayu_doctor/backend/chat_service.dart';
import 'package:ayu_doctor/models/patient.dart';
import 'package:expandable/expandable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayu_doctor/utils/colors.dart';

import 'chat.dart';

class Bookings extends StatefulWidget {
  const Bookings({Key? key}) : super(key: key);

  @override
  State<Bookings> createState() => _BookingsState();
}

final currentDoctor = FirebaseAuth.instance.currentUser!;

class _BookingsState extends State<Bookings> {
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: _height * 0.2,
            width: _width,
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
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
                                'Bookings',
                                style: TextStyle(
                                  fontFamily: 'InterBold',
                                  fontSize: 27,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    )),
          ),
          Flexible(
            child: LayoutBuilder(
              builder: (context, constraints) => ListView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                scrollDirection: Axis.vertical,
                children: <Widget>[
                  StreamBuilder<List<String?>>(
                      stream: BookingBackend().readPatientIds(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _height / 4),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          );
                        } else if (!snapshot.hasData) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(vertical: _height / 4),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          );
                        } else {
                          final patientIdNo = snapshot.data!;
                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: patientIdNo.length,
                            itemBuilder: ((context, index) => BookingCardWidget(
                                  constraints: constraints,
                                  patientId: patientIdNo[index]!,
                                  height: _height,
                                )),
                          );
                        }
                      }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BookingCardWidget extends StatelessWidget {
  final BoxConstraints constraints;
  final String patientId;
  final double height;
  const BookingCardWidget({
    Key? key,
    required this.constraints,
    required this.patientId,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Patient>(
        stream: BookingBackend().getPatientData(patientId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // getFututereatient();
            return const Text("Error");
          } else if (snapshot.hasData) {
            final patient = snapshot.data!;
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40.0),
              ),
              elevation: 8,
              shadowColor: iconBackgroundColor,
              margin: const EdgeInsets.only(bottom: 20),
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
                  child: ExpandablePanel(
                    theme: const ExpandableThemeData(
                        iconColor: Colors.transparent),
                    header: Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                              height: constraints.maxWidth * 0.15,
                              width: constraints.maxWidth * 0.2,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: iconBackgroundColor,
                                image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/doctor_male.png'),
                                  fit: BoxFit.contain,
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
                                height: constraints.maxHeight * 0.04,
                                child: Text(
                                  patient.name,
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
                              const Text(
                                'Last counsult 09/12/21',
                                style: TextStyle(
                                  fontFamily: 'InterMedium',
                                  fontSize: 15,
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
                                      image: AssetImage(
                                          'assets/icons/records.png'),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Chat(
                                                patient: patient,
                                              ))),
                                  child: Container(
                                    height: constraints.maxHeight * 0.04,
                                    width: constraints.maxHeight * 0.04,
                                    decoration: const BoxDecoration(
                                      image: DecorationImage(
                                        image:
                                            AssetImage('assets/icons/chat.png'),
                                        fit: BoxFit.contain,
                                      ),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: constraints.maxHeight * 0.04,
                                  width: constraints.maxHeight * 0.04,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/icons/history.png'),
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
          return Padding(
            padding: EdgeInsets.symmetric(vertical: height / 4),
            child: const Center(child: CircularProgressIndicator()),
          );
        });
  }
}
