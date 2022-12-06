import 'package:firebase_auth/firebase_auth.dart';
import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';


class JitsiMeetMethods {
  // final AuthMethods _authMethods = AuthMethods();

  void createMeeting({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String username = '',
  }) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution
          .MD_RESOLUTION; // Limit video resolution to 360p
      String name;
      if (username.isEmpty) {
        name = FirebaseAuth.instance.currentUser!.displayName.toString();
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = FirebaseAuth.instance.currentUser!.email.toString()
        ..userAvatarURL = FirebaseAuth.instance.currentUser!.photoURL.toString()
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;

  //    _firestoreMethods.addToMeetingHistory(roomName);
      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print("error: $error");
    }
  }
}
