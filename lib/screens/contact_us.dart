// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors.dart';
import 'dart:math' as math;

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  String mail = "sajanaakash06@gmail.com";
  @override
  Widget build(BuildContext context) {
    final _height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
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
                                'Contact Us',
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
          Column(
            children: <Widget>[
              Center(
                child: Container(
                  margin: const EdgeInsets.fromLTRB(50, 10, 40, 10),
                  height: _width * 0.6,
                  width: _width * 0.6,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/contacts.png'),
                        fit: BoxFit.contain),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextButton(
                    onPressed: () {
                      launch("mailto:$mail");
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                      backgroundColor:
                          MaterialStateProperty.all(secondaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        SizedBox(
                          height: 30.0,
                          width: 30.0,
                          child: ImageIcon(
                            AssetImage('assets/icons/mail.png'),
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Mail Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'InterBold',
                          ),
                        ),
                      ],
                    )),
              ),
              SizedBox(
                height: _height * 0.04,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.5,
                child: TextButton(
                    onPressed: () {
                      // ignore: deprecated_member_use
                      launch("tel://${0771798475}");
                    },
                    style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                      backgroundColor:
                          MaterialStateProperty.all(secondaryColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: 30.0,
                            width: 30.0,
                            child: Transform(
                              transform: Matrix4.rotationX(math.pi),
                              alignment: Alignment.center,
                              child: const ImageIcon(
                                AssetImage('assets/icons/call.png'),
                                color: Colors.white,
                              ),
                            )),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Call Us',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontFamily: 'InterBold',
                          ),
                        ),
                      ],
                    )),
              ),
              Column(
                children: <Widget>[
                  Center(
                      child: Container(
                    margin: const EdgeInsets.fromLTRB(50, 120, 40, 10),
                    height: _height * 0.12,
                    width: _width * 0.3,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/app_icon.png'),
                          fit: BoxFit.contain),
                    ),
                  )),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
