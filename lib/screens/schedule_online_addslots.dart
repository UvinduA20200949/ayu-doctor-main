import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ayu_doctor/utils/colors.dart';

class AddSlotsDialog extends StatefulWidget {
  final int wDay;
  final Function(TimeOfDay selectedFromTime, TimeOfDay selectedToTime,
      String? selectedValueSlots) onValueChanged;

  const AddSlotsDialog(
      {Key? key, required this.wDay, required this.onValueChanged})
      : super(key: key);

  @override
  _AddSlotsDialogState createState() => _AddSlotsDialogState();
}

class _AddSlotsDialogState extends State<AddSlotsDialog> {
  String? selectedValueSlots;
  TimeOfDay selectedFromTime = TimeOfDay.now();
  TimeOfDay selectedToTime =
      TimeOfDay.fromDateTime(DateTime.now().add(const Duration(minutes: 30)));
  DateTime dateToday = DateTime.now();
  String formattedFromTime = '';
  String formattedToTime = '';

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: Container(
            width: _width,
            height: _height * 0.52,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(35.0),
            ),
            child: LayoutBuilder(
                builder: (context, constraints) => Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: const EdgeInsets.only(bottom: 30),
                              child: dateText(widget.wDay)),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                const Text(
                                  'From',
                                  style: TextStyle(
                                    fontFamily: 'InterBold',
                                    fontSize: 20,
                                    color: secondaryColor,
                                  ),
                                ),
                                Column(
                                  children: [
                                    OutlinedButton(
                                      onPressed: () async {
                                        TimeOfDay? newTime =
                                            await showTimePicker(
                                                context: context,
                                                initialTime: selectedFromTime);
                                        if (newTime != null) {
                                          setState(() {
                                            selectedFromTime = newTime;
                                          });
                                        }
                                      },
                                      style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                            const BorderSide(
                                                color: secondaryColor,
                                                width: 1.5,
                                                style: BorderStyle.solid)),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                      ),
                                      child: const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Center(
                                          child: Text(
                                            'Select Time',
                                            style: TextStyle(
                                              color: secondaryColor,
                                              fontSize: 17,
                                              fontFamily: 'InterBold',
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      '${selectedFromTime.hourOfPeriod.toString().padLeft(2, '0')}:${selectedFromTime.minute.toString().padLeft(2, '0')} ${selectedFromTime.period.toString().substring(10)}'
                                          .toUpperCase(),
                                      style: const TextStyle(
                                        fontFamily: 'InterBold',
                                        fontSize: 12,
                                        color: quinaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  const Text(
                                    'To',
                                    style: TextStyle(
                                      fontFamily: 'InterBold',
                                      fontSize: 20,
                                      color: secondaryColor,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      OutlinedButton(
                                        onPressed: () async {
                                          TimeOfDay? newTime =
                                              await showTimePicker(
                                                  context: context,
                                                  initialTime: selectedToTime);
                                          if (newTime != null) {
                                            setState(() {
                                              selectedToTime = newTime;
                                            });
                                          }
                                        },
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                              const BorderSide(
                                                  color: secondaryColor,
                                                  width: 1.5,
                                                  style: BorderStyle.solid)),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                        ),
                                        child: const Padding(
                                          padding: EdgeInsets.all(10.0),
                                          child: Center(
                                            child: Text(
                                              'Select Time',
                                              style: TextStyle(
                                                color: secondaryColor,
                                                fontSize: 17,
                                                fontFamily: 'InterBold',
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        '${selectedToTime.hourOfPeriod.toString().padLeft(2, '0')}:${selectedToTime.minute.toString().padLeft(2, '0')} ${selectedToTime.period.toString().substring(10)}'
                                            .toUpperCase(),
                                        style: const TextStyle(
                                          fontFamily: 'InterBold',
                                          fontSize: 12,
                                          color: quinaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 50, bottom: 30),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Choose How Many Slots',
                                  style: TextStyle(
                                      fontFamily: 'InterBold',
                                      color: secondaryColor,
                                      fontSize: 16),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  height: _height * 0.04,
                                  child: DropdownButton(
                                    hint: const Text(
                                      '',
                                      style: TextStyle(
                                          fontFamily: 'InterBold',
                                          color: secondaryColor,
                                          fontSize: 16),
                                    ),
                                    value: selectedValueSlots,
                                    items: dropdownItemsSlots,
                                    icon: const Padding(
                                      padding: EdgeInsets.only(left: 3),
                                      child: ImageIcon(
                                        AssetImage("assets/icons/down.png"),
                                        color: primaryText,
                                      ),
                                    ),
                                    iconSize: 25,
                                    underline: const SizedBox(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedValueSlots = newValue!;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: _height * 0.07,
                            width: _width * 0.35,
                            child: TextButton(
                                onPressed: () async {
                                  int startTime = (selectedFromTime.hour * 60 +
                                      selectedFromTime.minute);
                                  int endTime = (selectedToTime.hour * 60 +
                                      selectedToTime.minute);
                                  int diffrence = endTime - startTime;

                                  log('Diffrence: $diffrence Slots: $selectedValueSlots');

                                  if (diffrence == 30 ||
                                      diffrence == 60 ||
                                      diffrence == 90 ||
                                      diffrence == 120 ||
                                      diffrence == 150 ||
                                      diffrence == 180 ||
                                      diffrence == 210 ||
                                      diffrence == 240 ||
                                      diffrence == 270 ||
                                      diffrence == 300) {
                                    formattedFromTime =
                                        '${selectedFromTime.hourOfPeriod.toString().padLeft(2, '0')}:${selectedFromTime.minute.toString().padLeft(2, '0')} ${selectedFromTime.period.toString().substring(10)}'
                                            .toUpperCase();
                                    formattedToTime =
                                        '${selectedToTime.hourOfPeriod.toString().padLeft(2, '0')}:${selectedToTime.minute.toString().padLeft(2, '0')} ${selectedToTime.period.toString().substring(10)}'
                                            .toUpperCase();

                                    final sTime = TimeOfDay(
                                        hour: selectedFromTime.hour,
                                        minute: selectedFromTime.minute);
                                    final eTime = TimeOfDay(
                                        hour: selectedToTime.hour,
                                        minute: selectedToTime.minute);
                                    const interval = Duration(minutes: 30);

                                    if (selectedValueSlots == '01' ||
                                        selectedValueSlots == '02' ||
                                        selectedValueSlots == '03' ||
                                        selectedValueSlots == '04' ||
                                        selectedValueSlots == '05' ||
                                        selectedValueSlots == '06' ||
                                        selectedValueSlots == '07' ||
                                        selectedValueSlots == '08' ||
                                        selectedValueSlots == '09' ||
                                        selectedValueSlots == '10') {
                                      final times =
                                          getTimeSlots(sTime, eTime, interval)
                                              .toList();

                                      if (diffrence == 30 &&
                                          selectedValueSlots == '01') {
                                        addAppointmentToFirestore(
                                            formattedFromTime);
                                      } else if (diffrence == 60 &&
                                          selectedValueSlots == '02') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                      } else if (diffrence == 90 &&
                                          selectedValueSlots == '03') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                      } else if (diffrence == 120 &&
                                          selectedValueSlots == '04') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot4Time =
                                            '${times[3].hourOfPeriod.toString().padLeft(2, '0')}:${times[3].minute.toString().padLeft(2, '0')} ${times[3].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                        await addAppointmentToFirestore(
                                            slot4Time);
                                      } else if (diffrence == 150 &&
                                          selectedValueSlots == '05') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot4Time =
                                            '${times[3].hourOfPeriod.toString().padLeft(2, '0')}:${times[3].minute.toString().padLeft(2, '0')} ${times[3].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot5Time =
                                            '${times[4].hourOfPeriod.toString().padLeft(2, '0')}:${times[4].minute.toString().padLeft(2, '0')} ${times[4].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                        await addAppointmentToFirestore(
                                            slot4Time);
                                        await addAppointmentToFirestore(
                                            slot5Time);
                                      } else if (diffrence == 180 &&
                                          selectedValueSlots == '06') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot4Time =
                                            '${times[3].hourOfPeriod.toString().padLeft(2, '0')}:${times[3].minute.toString().padLeft(2, '0')} ${times[3].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot5Time =
                                            '${times[4].hourOfPeriod.toString().padLeft(2, '0')}:${times[4].minute.toString().padLeft(2, '0')} ${times[4].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot6Time =
                                            '${times[5].hourOfPeriod.toString().padLeft(2, '0')}:${times[5].minute.toString().padLeft(2, '0')} ${times[5].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                        await addAppointmentToFirestore(
                                            slot4Time);
                                        await addAppointmentToFirestore(
                                            slot5Time);
                                        await addAppointmentToFirestore(
                                            slot6Time);
                                      } else if (diffrence == 210 &&
                                          selectedValueSlots == '07') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot4Time =
                                            '${times[3].hourOfPeriod.toString().padLeft(2, '0')}:${times[3].minute.toString().padLeft(2, '0')} ${times[3].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot5Time =
                                            '${times[4].hourOfPeriod.toString().padLeft(2, '0')}:${times[4].minute.toString().padLeft(2, '0')} ${times[4].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot6Time =
                                            '${times[5].hourOfPeriod.toString().padLeft(2, '0')}:${times[5].minute.toString().padLeft(2, '0')} ${times[5].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot7Time =
                                            '${times[6].hourOfPeriod.toString().padLeft(2, '0')}:${times[6].minute.toString().padLeft(2, '0')} ${times[6].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                        await addAppointmentToFirestore(
                                            slot4Time);
                                        await addAppointmentToFirestore(
                                            slot5Time);
                                        await addAppointmentToFirestore(
                                            slot6Time);
                                        await addAppointmentToFirestore(
                                            slot7Time);
                                      } else if (diffrence == 240 &&
                                          selectedValueSlots == '08') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot4Time =
                                            '${times[3].hourOfPeriod.toString().padLeft(2, '0')}:${times[3].minute.toString().padLeft(2, '0')} ${times[3].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot5Time =
                                            '${times[4].hourOfPeriod.toString().padLeft(2, '0')}:${times[4].minute.toString().padLeft(2, '0')} ${times[4].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot6Time =
                                            '${times[5].hourOfPeriod.toString().padLeft(2, '0')}:${times[5].minute.toString().padLeft(2, '0')} ${times[5].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot7Time =
                                            '${times[6].hourOfPeriod.toString().padLeft(2, '0')}:${times[6].minute.toString().padLeft(2, '0')} ${times[6].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot8Time =
                                            '${times[7].hourOfPeriod.toString().padLeft(2, '0')}:${times[7].minute.toString().padLeft(2, '0')} ${times[7].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                        await addAppointmentToFirestore(
                                            slot4Time);
                                        await addAppointmentToFirestore(
                                            slot5Time);
                                        await addAppointmentToFirestore(
                                            slot6Time);
                                        await addAppointmentToFirestore(
                                            slot7Time);
                                        await addAppointmentToFirestore(
                                            slot8Time);
                                      } else if (diffrence == 270 &&
                                          selectedValueSlots == '09') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot4Time =
                                            '${times[3].hourOfPeriod.toString().padLeft(2, '0')}:${times[3].minute.toString().padLeft(2, '0')} ${times[3].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot5Time =
                                            '${times[4].hourOfPeriod.toString().padLeft(2, '0')}:${times[4].minute.toString().padLeft(2, '0')} ${times[4].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot6Time =
                                            '${times[5].hourOfPeriod.toString().padLeft(2, '0')}:${times[5].minute.toString().padLeft(2, '0')} ${times[5].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot7Time =
                                            '${times[6].hourOfPeriod.toString().padLeft(2, '0')}:${times[6].minute.toString().padLeft(2, '0')} ${times[6].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot8Time =
                                            '${times[7].hourOfPeriod.toString().padLeft(2, '0')}:${times[7].minute.toString().padLeft(2, '0')} ${times[7].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot9Time =
                                            '${times[8].hourOfPeriod.toString().padLeft(2, '0')}:${times[8].minute.toString().padLeft(2, '0')} ${times[8].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                        await addAppointmentToFirestore(
                                            slot4Time);
                                        await addAppointmentToFirestore(
                                            slot5Time);
                                        await addAppointmentToFirestore(
                                            slot6Time);
                                        await addAppointmentToFirestore(
                                            slot7Time);
                                        await addAppointmentToFirestore(
                                            slot8Time);
                                        await addAppointmentToFirestore(
                                            slot9Time);
                                      } else if (diffrence == 300 &&
                                          selectedValueSlots == '10') {
                                        String slot1Time =
                                            '${times[0].hourOfPeriod.toString().padLeft(2, '0')}:${times[0].minute.toString().padLeft(2, '0')} ${times[0].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot2Time =
                                            '${times[1].hourOfPeriod.toString().padLeft(2, '0')}:${times[1].minute.toString().padLeft(2, '0')} ${times[1].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot3Time =
                                            '${times[2].hourOfPeriod.toString().padLeft(2, '0')}:${times[2].minute.toString().padLeft(2, '0')} ${times[2].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot4Time =
                                            '${times[3].hourOfPeriod.toString().padLeft(2, '0')}:${times[3].minute.toString().padLeft(2, '0')} ${times[3].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot5Time =
                                            '${times[4].hourOfPeriod.toString().padLeft(2, '0')}:${times[4].minute.toString().padLeft(2, '0')} ${times[4].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot6Time =
                                            '${times[5].hourOfPeriod.toString().padLeft(2, '0')}:${times[5].minute.toString().padLeft(2, '0')} ${times[5].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot7Time =
                                            '${times[6].hourOfPeriod.toString().padLeft(2, '0')}:${times[6].minute.toString().padLeft(2, '0')} ${times[6].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot8Time =
                                            '${times[7].hourOfPeriod.toString().padLeft(2, '0')}:${times[7].minute.toString().padLeft(2, '0')} ${times[7].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot9Time =
                                            '${times[8].hourOfPeriod.toString().padLeft(2, '0')}:${times[8].minute.toString().padLeft(2, '0')} ${times[8].period.toString().substring(10)}'
                                                .toUpperCase();
                                        String slot10Time =
                                            '${times[9].hourOfPeriod.toString().padLeft(2, '0')}:${times[9].minute.toString().padLeft(2, '0')} ${times[9].period.toString().substring(10)}'
                                                .toUpperCase();

                                        await addAppointmentToFirestore(
                                            slot1Time);
                                        await addAppointmentToFirestore(
                                            slot2Time);
                                        await addAppointmentToFirestore(
                                            slot3Time);
                                        await addAppointmentToFirestore(
                                            slot4Time);
                                        await addAppointmentToFirestore(
                                            slot5Time);
                                        await addAppointmentToFirestore(
                                            slot6Time);
                                        await addAppointmentToFirestore(
                                            slot7Time);
                                        await addAppointmentToFirestore(
                                            slot8Time);
                                        await addAppointmentToFirestore(
                                            slot9Time);
                                        await addAppointmentToFirestore(
                                            slot10Time);
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                                backgroundColor: secondaryColor,
                                                content: Text(
                                                  "Number of slots & duration does not match",
                                                  style: TextStyle(
                                                    fontFamily: 'InterMedium',
                                                    color: Colors.white,
                                                  ),
                                                )));
                                        Navigator.pop(context);
                                      }
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: secondaryColor,
                                              content: Text(
                                                "Appointments added",
                                                style: TextStyle(
                                                  fontFamily: 'InterMedium',
                                                  color: Colors.white,
                                                ),
                                              )));

                                      widget.onValueChanged(selectedFromTime,
                                          selectedToTime, selectedValueSlots);
                                      Navigator.pop(context);
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              backgroundColor: secondaryColor,
                                              content: Text(
                                                "Invalid number of slots",
                                                style: TextStyle(
                                                  fontFamily: 'InterMedium',
                                                  color: Colors.white,
                                                ),
                                              )));
                                      Navigator.pop(context);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                            backgroundColor: secondaryColor,
                                            content: Text(
                                              "Invalid time duration",
                                              style: TextStyle(
                                                fontFamily: 'InterMedium',
                                                color: Colors.white,
                                              ),
                                            )));
                                    Navigator.pop(context);
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0))),
                                  backgroundColor:
                                      MaterialStateProperty.all(quinaryColor),
                                ),
                                child: const Center(
                                  child: Text(
                                    'Add Slot',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontFamily: 'InterBold',
                                    ),
                                  ),
                                )),
                          ),
                        ]))));
  }

  Iterable<TimeOfDay> getTimeSlots(
      TimeOfDay startTime, TimeOfDay endTime, Duration interval) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += interval.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  Future addAppointmentToFirestore(time) async {
    String id = math.Random().nextInt(99999999).toString();

    String date = getWeekdayText(widget.wDay);
    DateTime parseDate = DateFormat("yyyy-MM-dd").parse(date);
    var inputDate = DateTime.parse(parseDate.toString());
    var outputDate = DateFormat.yMMMd().format(inputDate);

    await FirebaseFirestore.instance
        .collection('doctors')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('appointments')
        .doc(id)
        .set({
      'id': id,
      'date': outputDate,
      'time': time,
      'ayu_fee': 1500.55,
      'fee': 2000.55,
      'discount': 100.55,
      'total': 2300.55,
      'status': 'available',
      'sex': '',
      'first_name': '',
      'age': 0,
      'patient_uid': ''
    });
  }

  String getWeekdayText(int wDay) {
    String date;
    DateTime today = DateTime.now();
    DateTime firstDayOfTheweek =
        today.subtract(Duration(days: today.weekday - 7 - 1));

    if (wDay < dateToday.weekday) {
      if (wDay == 1) {
        date = firstDayOfTheweek.toString().substring(0, 10);
      } else if (wDay == 2) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 1));
        date = i.toString().substring(0, 10);
      } else if (wDay == 3) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 2));
        date = i.toString().substring(0, 10);
      } else if (wDay == 4) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 3));
        date = i.toString().substring(0, 10);
      } else if (wDay == 5) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 4));
        date = i.toString().substring(0, 10);
      } else if (wDay == 6) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 5));
        date = i.toString().substring(0, 10);
      } else {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 6));
        date = i.toString().substring(0, 10);
      }
      // date = dateToday
      //     .add(Duration(days: dateToday.weekday + wDay))
      //     .toString()
      //     .substring(0, 10);
    } else {
      date = dateToday
          .subtract(Duration(days: dateToday.weekday - wDay))
          .toString()
          .substring(0, 10);
    }

    return date;
  }

  Widget dateText(int wDay) {
    String date;
    DateTime today = DateTime.now();
    DateTime firstDayOfTheweek =
        today.subtract(Duration(days: today.weekday - 7 - 1));

    if (wDay < dateToday.weekday) {
      if (wDay == 1) {
        date = firstDayOfTheweek.toString().substring(0, 10);
      } else if (wDay == 2) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 1));
        date = i.toString().substring(0, 10);
      } else if (wDay == 3) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 2));
        date = i.toString().substring(0, 10);
      } else if (wDay == 4) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 3));
        date = i.toString().substring(0, 10);
      } else if (wDay == 5) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 4));
        date = i.toString().substring(0, 10);
      } else if (wDay == 6) {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 5));
        date = i.toString().substring(0, 10);
      } else {
        DateTime i = firstDayOfTheweek.add(const Duration(days: 6));
        date = i.toString().substring(0, 10);
      }
      // date = dateToday
      //     .add(Duration(days: dateToday.weekday + wDay))
      //     .toString()
      //     .substring(0, 10);
    } else {
      date = dateToday
          .subtract(Duration(days: dateToday.weekday - wDay))
          .toString()
          .substring(0, 10);
    }

    return Text(
      date,
      style: const TextStyle(
        fontFamily: 'InterBold',
        fontSize: 20,
        color: quinaryColor,
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItemsSlots {
    List<DropdownMenuItem<String>> menuItems = [
      const DropdownMenuItem(
          child: Text(
            '01',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "01"),
      const DropdownMenuItem(
          child: Text(
            '02',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "02"),
      const DropdownMenuItem(
          child: Text(
            '03',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "03"),
      const DropdownMenuItem(
          child: Text(
            '04',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "04"),
      const DropdownMenuItem(
          child: Text(
            '05',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "05"),
      const DropdownMenuItem(
          child: Text(
            '06',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "06"),
      const DropdownMenuItem(
          child: Text(
            '07',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "07"),
      const DropdownMenuItem(
          child: Text(
            '08',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "08"),
      const DropdownMenuItem(
          child: Text(
            '09',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "09"),
      const DropdownMenuItem(
          child: Text(
            '10',
            style: TextStyle(
                fontFamily: 'InterBold', color: secondaryColor, fontSize: 16),
          ),
          value: "10"),
    ];
    return menuItems;
  }
}
