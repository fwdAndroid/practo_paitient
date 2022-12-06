import 'dart:math';

import 'package:flutter/material.dart';
import 'package:practo_paitient/bottompages/chats/videochat/methods/methods.dart';
import 'package:practo_paitient/bottompages/chats/videochat/video_call.dart';
import 'package:practo_paitient/bottompages/chats/videochat/widgets/home_meeting_button.dart';

class MeetingScreen extends StatelessWidget {
  MeetingScreen({Key? key}) : super(key: key);

  final JitsiMeetMethods _jitsiMeetMethods = JitsiMeetMethods();

  createNewMeeting() async {
    var random = Random();
    String roomName = (random.nextInt(10000000) + 10000000).toString();
    _jitsiMeetMethods.createMeeting(
        roomName: roomName, isAudioMuted: true, isVideoMuted: true);
  }

  joinMeeting(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (builder) => VideoCallScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                HomeMeetingButton(
                  onPressed: createNewMeeting,
                  text: 'New Meeting',
                  icon: Icons.videocam,
                ),
                HomeMeetingButton(
                  onPressed: () => joinMeeting(context),
                  text: 'Join Meeting',
                  icon: Icons.add_box_rounded,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
