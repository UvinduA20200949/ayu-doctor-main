import 'dart:math';

import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:ayu_doctor/models/call.dart';
import 'package:ayu_doctor/models/doc.dart';
import 'package:ayu_doctor/models/user.dart';
import 'package:ayu_doctor/resources/call_methods.dart';
import 'package:ayu_doctor/screens/call_screen.dart';
import 'package:flutter/material.dart';

class CallUtils {
  static final CallMethods callMethods = CallMethods();
  static const ClientRole? _role = ClientRole.Broadcaster;

  static dial({required Doctor from, required User to, context}) async {
    Call call = Call(
      callerId: from.uid,
      callerName: from.name,
      callerPic: from.profilePictureUrl,
      receiverId: to.uid,
      receiverName: to.name,
      receiverPic: to.profilePictureUrl,
      channelId: Random().nextInt(1000).toString(),
      hasDialled: null,
    );

    bool callMade = await callMethods.makeCall(call: call);

    call.hasDialled = true;

    if (callMade) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CallScreen(call: call, role: _role),
          ));
    }
  }
}
