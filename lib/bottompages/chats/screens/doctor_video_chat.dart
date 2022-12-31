import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'dart:math' as math;

class DoctorVideoCall extends StatefulWidget {
  String callingId;
  String paitientname;
  DoctorVideoCall(
      {super.key, required this.callingId, required this.paitientname});

  @override
  State<DoctorVideoCall> createState() => _DoctorVideoCallState();
}

class _DoctorVideoCallState extends State<DoctorVideoCall> {
  final String localUserID = math.Random().nextInt(10000).toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ZegoUIKitPrebuiltCall(
      appID: 1176727441,
      appSign:
          "2b2e33eb1dc64a9d7fc09ad3e0064a9a95907b278184fbb94fad6455a5670edc",
      userID: localUserID,
      userName: widget.paitientname + '$localUserID',
      callID: widget.callingId,
      config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
        ..layout = ZegoLayout.pictureInPicture(
          isSmallViewDraggable: true,
          switchLargeOrSmallViewByClick: true,
        ),
    ));
  }
}
