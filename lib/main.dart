import 'package:ayu_doctor/provider/doctor_provider.dart';
import 'package:ayu_doctor/screens/home.dart';
import 'package:ayu_doctor/screens/sign_in.dart';
import 'package:ayu_doctor/screens/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FlutterDownloader.initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? firebaseUser = FirebaseAuth.instance.currentUser;
    Widget firstWidget;

    if (firebaseUser != null) {
      firstWidget = const Home();
    } else {
      firstWidget = const SignIn();
    }

    return ChangeNotifierProvider<DoctorProvider>(
      create: (context) => DoctorProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(),
          home: SplashScreen(
            nextScreen: firstWidget,
          )),
    );
  }
}
