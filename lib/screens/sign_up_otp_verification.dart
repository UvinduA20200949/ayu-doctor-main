import 'dart:developer';

import 'package:ayu_doctor/screens/create_account.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ayu_doctor/utils/colors.dart';
import 'package:pinput/pinput.dart';

import '../utils/colors.dart';

class SignUpOtpVerification extends StatefulWidget {
  final String phone;
  final String firstname;
  final String lastname;
  final String email;
  // ignore: use_key_in_widget_constructors
  const SignUpOtpVerification(
      this.phone, this.firstname, this.lastname, this.email);

  @override
  State<SignUpOtpVerification> createState() => _SignUpOtpVerificationState();
}

class _SignUpOtpVerificationState extends State<SignUpOtpVerification> {
  String _verificationCode = '';

  @override
  void initState() {
    super.initState();
    verifyPhone();
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: secondaryColor),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: secondaryColor),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        alignment: Alignment.center,
        children: [
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
                      'We Have sent OTP To Your',
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
                      'Contact Number',
                      style: TextStyle(
                        fontFamily: 'InterBold',
                        fontSize: 17,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.03,
                    ),
                    Text(
                      '+94${widget.phone}',
                      style: const TextStyle(
                        fontFamily: 'InterMedium',
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
            Center(
              child: Container(
                height: _height * 0.4,
                width: _width,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Medicine-pana-1.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: _height * 0.01,
            // ),
          ]),
          Positioned(
              bottom: _height * 0.55,
              child: LayoutBuilder(
                  builder: (context, constraints) => Card(
                      elevation: 10,
                      shadowColor: iconBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Container(
                        width: _width * 0.9,
                        height: _height * 0.2,
                        padding: const EdgeInsets.fromLTRB(20, 50, 20, 30),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) => Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Pinput(
                                  length: 6,
                                  pinAnimationType: PinAnimationType.scale,
                                  defaultPinTheme: defaultPinTheme,
                                  focusedPinTheme: focusedPinTheme,
                                  submittedPinTheme: submittedPinTheme,
                                  pinputAutovalidateMode:
                                      PinputAutovalidateMode.onSubmit,
                                  showCursor: true,
                                  onCompleted: (pin) => moveToNextScreen(pin),
                                ),
                              )
                            ],
                          ),
                        ),
                      ))))
        ],
      ),
    );
  }

  verifyPhone() async {
    log('+94${widget.phone}');
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+94${widget.phone}',
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        verificationCompleted: (PhoneAuthCredential) async {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: secondaryColor,
              content: Text(
                "OTP sent successfully",
                style: TextStyle(
                  fontFamily: 'InterMedium',
                  color: Colors.white,
                ),
              )));
        },
        verificationFailed: (FirebaseAuthException e) {
          log('Sign in - ' + e.message.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: secondaryColor,
              content: Text(
                e.message.toString(),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                style: const TextStyle(
                  fontFamily: 'InterMedium',
                  color: Colors.white,
                ),
              )));
        },
        codeSent: (String verificationID, int? resendToken) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        codeAutoRetrievalTimeout: (verificationID) async {},
        timeout: const Duration(seconds: 40));
  }

  Future moveToNextScreen(String pin) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => CreateAccount(
                      widget.phone,
                      widget.firstname,
                      widget.lastname,
                      widget.email,
                      value.user!.uid)),
              (route) => false);
        }
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: secondaryColor,
          content: Text(
            'Invalid OTP provided',
            style: TextStyle(
              fontFamily: 'InterMedium',
              color: Colors.white,
            ),
          )));
      log(e.toString());
    }
  }
}
