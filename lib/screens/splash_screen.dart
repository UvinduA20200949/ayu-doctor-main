import 'package:flutter/material.dart';
import '../utils/colors.dart';

class SplashScreen extends StatefulWidget {
  final Widget nextScreen;
  const SplashScreen({Key? key, required this.nextScreen}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 2000), () {});

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => widget.nextScreen));
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
              height: _height,
              width: _width,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.3, 0.8],
                    colors: [primaryColor.withOpacity(0.9), Colors.white]),
              ),
              child: LayoutBuilder(
                  builder: (context, constraints) => Stack(children: [
                        Container(
                          height: constraints.maxHeight * 0.20,
                          margin: EdgeInsets.only(
                              top: constraints.maxHeight * 0.10),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/app_icon.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: constraints.maxHeight * 0.50,
                                width: constraints.maxWidth,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/Medicine-bro.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'www.ayuthehelth.com',
                              style: TextStyle(
                                fontFamily: 'InterBold',
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: _height * 0.05,
                            ),
                            const Text(
                              'Power By Shield Technologies (Pvt) Ltd',
                              style: TextStyle(
                                fontFamily: 'InterBold',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ])))
        ],
      ),
    );
  }
}
