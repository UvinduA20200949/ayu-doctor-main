import 'dart:developer';

import 'package:ayu_doctor/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class ComplainAndFeedback extends StatefulWidget {
  const ComplainAndFeedback({Key? key}) : super(key: key);

  @override
  State<ComplainAndFeedback> createState() => _ComplainAndFeedbackState();
}

class _ComplainAndFeedbackState extends State<ComplainAndFeedback> {
  List<bool> isTypeSelected = [false, false, false, false];
  var feedbackType = [];

  final _bodyController = TextEditingController(
    text: 'Mail body.',
  );

  Future<void> send() async {
    log('-----send feedback email-------');

    final Email email = Email(
      body: await bodyText(_bodyController.text),
      subject: 'Feedback & Complaints',
      recipients: ['ewiduhala@gmail.com'],
      // isHTML: isHTML,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = 'success';
      log('------feedback sent success---------');
    } catch (error) {
      platformResponse = error.toString();
      log('------feedback sent failure---------');
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  Future<String> bodyText(body) async {
    // while(isTypeSelected)
    log('-----------------------------------------');
    var title = 'Feedback Type';
    return title + "\n\n" + feedbackType.toString() + "\n\n\n\n" + body;
  }

  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return (Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                              margin: const EdgeInsets.only(left: 5, top: 30),
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
                          SizedBox(
                            height: constraints.maxHeight * 0.01,
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text(
                                  'Complain & Feedback',
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
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10.0,
                  ),
                  // Text(
                  //   "Please select the type of the feedback",
                  //   style: TextStyle(
                  //     color: Color(0xFF808080),
                  //   ),
                  // ),
                  // SizedBox(height: 25.0),
                  GestureDetector(
                    child: buildCheckItem(
                        title: "Login/Logout trouble", isSelected: isTypeSelected[0]),
                    onTap: () {
                      setState(() {
                        isTypeSelected[0] = !isTypeSelected[0];
                        if (isTypeSelected[0] == true) {
                          feedbackType.add('Login trouble');
                        }
                      });
                    },
                  ),
                  GestureDetector(
                    child: buildCheckItem(
                        title: "Bugs and issues",
                        isSelected: isTypeSelected[1]),
                    onTap: () {
                      setState(() {
                        isTypeSelected[1] = !isTypeSelected[1];
                        if (isTypeSelected[1] == true) {
                          feedbackType.add('Bugs and issues');
                        }
                      });
                    },
                  ),
                  
                  GestureDetector(
                    child: buildCheckItem(
                        title: "Suggestions", isSelected: isTypeSelected[4]),
                    onTap: () {
                      setState(() {
                        isTypeSelected[2] = !isTypeSelected[4];
                        if (isTypeSelected[2] == true) {
                          feedbackType.add('Suggestions');
                        }
                      });
                    },
                  ),
                  GestureDetector(
                    child: buildCheckItem(
                        title: "Other issues", isSelected: isTypeSelected[3]),
                    onTap: () {
                      setState(() {
                        isTypeSelected[3] = !isTypeSelected[3];
                        if (isTypeSelected[3] == true) {
                          feedbackType.add('Other issues');
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  // buildFeedbackForm(),
                  const SizedBox(height: 20.0),
                  // Spacer(),
                ],
              ),
            ),
            const SizedBox(
              height: 25.0,
            ),
            buildFeedbackForm(),
            SizedBox(
              height: _height * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: deprecated_member_use
                FlatButton(
                  onPressed: send,
                  child: const Text(
                    "SUBMIT",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  color: const Color.fromARGB(255, 49, 143, 250),
                  padding: const EdgeInsets.all(16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ));
  }

  buildFeedbackForm() {
    return Container(
      height: 200.0,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Stack(
        children: const <Widget>[
          TextField(
            maxLines: 10,
            decoration: InputDecoration(
              hintText: "Please type your issue......",
              hintStyle: TextStyle(
                fontSize: 15.0,
                fontFamily: 'InterMedium',
                color: secondaryText,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                borderSide: BorderSide(color: secondaryText),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildCheckItem({required String title, required bool isSelected}) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.circle,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(width: 10.0),
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? Colors.blue : Colors.grey),
          ),
        ],
      ),
    );
  }
}
