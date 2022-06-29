import '../utils/colors.dart';
import 'package:flutter/material.dart';

class WebinarSession extends StatefulWidget {
  const WebinarSession({Key? key}) : super(key: key);

  @override
  State<WebinarSession> createState() => _WebinarSessionState();
}

class _WebinarSessionState extends State<WebinarSession> {
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
                                'Webinar Session',
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
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 100),
            child: const Text(
              'Coming soon',
              style: TextStyle(
                fontFamily: 'InterBold',
                fontSize: 27,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
