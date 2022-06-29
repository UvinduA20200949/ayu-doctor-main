import 'package:ayu_doctor/screens/bookings.dart';
import 'package:ayu_doctor/screens/ongoing_session.dart';
import 'package:ayu_doctor/utils/colors.dart';
import 'package:flutter/material.dart';

class OngoingConsultant extends StatefulWidget {
  const OngoingConsultant({Key? key}) : super(key: key);

  @override
  _OngoingConsultantState createState() => _OngoingConsultantState();
}

class _OngoingConsultantState extends State<OngoingConsultant> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentIndex == 1 ? const Bookings() : const Ongoing(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: secondaryColor,
        selectedItemColor: Colors.white,
        currentIndex: currentIndex,
        unselectedItemColor: Colors.white70,
        iconSize: 35,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() {
          currentIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/stethoscope.png'),
            ),
            label: 'Ongoing',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/medical_book.png'),
            ),
            label: 'Bookings',
          )
        ],
      ),
    );
  }
}
