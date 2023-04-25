import 'package:jitsi_meet/jitsi_meet.dart';

class Jitsi {
  static void joinMeeting(String roomName) async {
    try {
      var options = JitsiMeetingOptions(room: roomName)
      //..room = roomName
        ..audioMuted = true
        ..videoMuted = true;

      await JitsiMeet.joinMeeting(options);
    } catch (error) {
      print(error.toString());
    }
  }
}