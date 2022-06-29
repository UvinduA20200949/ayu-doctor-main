import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/resources/firebase_repository.dart';
import 'package:flutter/material.dart';
import 'package:ayu_doctor/screens/menu.dart';
import '../utils/colors.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  bool isCheck = false;
  // ignore: unused_element
  void _valueChanged(bool value) => setState(() => value);

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: FutureBuilder(
          future: getDoctor(),
          builder: (context, AsyncSnapshot<Doctor> snapshot) {
            if (snapshot.hasData) {
              return const Menu();
            } else {
              return Container();
            }
          },
        ),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(alignment: Alignment.center, children: [
          Column(children: <Widget>[
            Container(
              height: 200,
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
                            margin: const EdgeInsets.only(top: 40, left: 20),
                            child: const Icon(
                              Icons.menu,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 230,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                ),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0))),
                                backgroundColor:
                                    MaterialStateProperty.all(quinaryColor),
                              ),
                              child: const Text(
                                'Offline',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: 'InterBold',
                                ),
                              )),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   alignment: Alignment.center,
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     children: const <Widget>[

                    //     ],
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ]),
          Positioned(
              bottom: _width * 0.10,
              child: LayoutBuilder(
                  builder: (context, constraints) => Card(
                      elevation: 10,
                      shadowColor: iconBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: Container(
                          width: _width * 0.85,
                          height: _height * 0.85,
                          padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(35.0),
                          ),
                          child: LayoutBuilder(
                              builder: (context, constraints) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        const Text(
                                          'Please wait until\nVerify Your Account',
                                          style: TextStyle(
                                            fontFamily: 'InterBold',
                                            fontSize: 28,
                                            color: quinaryColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: _height * 0.10,
                                        ),
                                        Container(
                                          height: constraints.maxHeight * 0.50,
                                          width: constraints.maxWidth,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/app_icon.png'),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        )
                                      ]))))))
        ]));
  }

  Future<Doctor> getDoctor() async {
    final FirebaseRepository _firebaseRepository = FirebaseRepository();
    Doctor doctor = await _firebaseRepository.getDoctorDetails();
    return doctor;
  }
}
