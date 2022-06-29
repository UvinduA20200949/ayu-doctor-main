import 'package:ayu_doctor/screens/sign_up_otp_verification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';

class SendOtp extends StatefulWidget {
  final String firstname;
  final String lastname;
  final String email;
  // ignore: use_key_in_widget_constructors
  const SendOtp(
    this.firstname,
    this.lastname,
    this.email,
  );

  @override
  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  final TextEditingController _phoneNumberController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  FocusNode focusNode = FocusNode();
  String hintText = 'Enter mobile number';

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        hintText = '71XXXXXXX';
      } else {
        hintText = 'Enter mobile number';
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

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
              padding: const EdgeInsets.fromLTRB(40, 60, 40, 0),
              height: _height * 0.4,
              width: _width,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [primaryColor, secondaryColor],
                  stops: [0.3, 1],
                ),
              ),
              child: LayoutBuilder(
                builder: (context, constraints) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Welcome!',
                      style: TextStyle(
                        fontFamily: 'InterBold',
                        fontSize: 27,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.1,
                    ),
                    const Text(
                      'Enter Your Mobile Number',
                      style: TextStyle(
                        fontFamily: 'InterBold',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.01,
                    ),
                    const Text(
                      'To Sign Up',
                      style: TextStyle(
                        fontFamily: 'InterBold',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Expanded(
                child: SizedBox(
              height: 0,
            )),
            Container(
              height: _height * 0.4,
              width: _width * 0.9,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/Medicine-pana-1.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // SizedBox(
            //   height: _height * 0.04,
            // ),
          ]),
          Positioned(
              bottom: _width,
              child: LayoutBuilder(
                  builder: (context, constraints) => Card(
                      elevation: 10,
                      shadowColor: iconBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                          width: _width * 0.9,
                          height: _height * 0.25,
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
                                        Form(
                                          key: _key,
                                          child: TextFormField(
                                            focusNode: focusNode,
                                            autovalidateMode: AutovalidateMode
                                                .onUserInteraction,
                                            controller: _phoneNumberController,
                                            validator: validatePhone,
                                            textAlignVertical:
                                                TextAlignVertical.center,
                                            style: const TextStyle(
                                                color: primaryText,
                                                fontFamily: 'InterMedium',
                                                fontSize: 15),
                                            decoration: InputDecoration(
                                              isDense: true,
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: BorderSide.none),
                                              fillColor:
                                                  Colors.grey.withOpacity(0.1),
                                              filled: true,
                                              counterText: '',
                                              errorStyle: const TextStyle(
                                                fontFamily: 'InterMedium',
                                              ),
                                              prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20, right: 15),
                                                  child: SizedBox(
                                                    width:
                                                        constraints.maxWidth *
                                                            0.17,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: const <Widget>[
                                                        Icon(
                                                          Icons
                                                              .phone_android_rounded,
                                                          color: secondaryText,
                                                        ),
                                                        SizedBox(
                                                          width: 5,
                                                        ),
                                                        Text(
                                                          '+94',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'InterMedium',
                                                              color:
                                                                  secondaryText,
                                                              fontSize: 15),
                                                        )
                                                      ],
                                                    ),
                                                  )),
                                              hintText: hintText,
                                              hintStyle: const TextStyle(
                                                fontFamily: 'InterMedium',
                                                color: secondaryText,
                                              ),
                                            ),
                                            cursorColor: secondaryColor,
                                            maxLines: 1,
                                            maxLength: 9,
                                            keyboardType: TextInputType.phone,
                                            textInputAction:
                                                TextInputAction.done,
                                          ),
                                        ),
                                        SizedBox(
                                          height: constraints.maxHeight * 0.1,
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth * 0.6,
                                          child: TextButton(
                                              onPressed: moveToNextScreen,
                                              style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    12.0))),
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                        secondaryColor),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  'Send OTP',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 17,
                                                    fontFamily: 'InterBold',
                                                  ),
                                                ),
                                              )),
                                        ),
                                      ]))))))
        ]));
  }

  Future checkIfUserAlreadyExists(String phoneNumber, String firstname,
      String lastname, String email) async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('doctors')
        .where('phone_number', isEqualTo: '+94$phoneNumber')
        .get();

    if (!query.docs.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              SignUpOtpVerification(phoneNumber, firstname, lastname, email),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: secondaryColor,
          content: Text(
            "User already exists",
            style: TextStyle(
              fontFamily: 'InterMedium',
              color: Colors.white,
            ),
          )));
    }
    return null;
  }

  Future passDataBack() async {
    if (_key.currentState!.validate()) {
      Navigator.pop(context);
    }
  }

  Future moveToNextScreen() async {
    if (_key.currentState!.validate()) {
      checkIfUserAlreadyExists(_phoneNumberController.text, widget.firstname,
          widget.lastname, widget.email);
    }
  }

  String? validatePhone(String? formPhone) {
    if (formPhone == null || formPhone.isEmpty) {
      return "Field can't be empty";
    } else if (formPhone.length < 9) {
      return 'Enter at least 9 digits';
    }

    return null;
  }
}
