import 'package:booking_calendar/booking_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_paitient/doctors/appointment/paitent_detaills.dart';

class ConfrimAppointment extends StatefulWidget {
  const ConfrimAppointment({Key? key}) : super(key: key);

  @override
  State<ConfrimAppointment> createState() => _ConfrimAppointmentState();
}

class _ConfrimAppointmentState extends State<ConfrimAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Dr.Shang chi",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Chose An Hour",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Center(
                    child: ListTile(
                      leading: Container(
                        width: 67,
                        height: 56,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffE4ECFE)),
                        child: Icon(
                          Icons.person_search,
                          color: Color(0xff1060D7),
                        ),
                      ),
                      title: Text(
                        "Messaging",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Can messaging with Doctor",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "\$5",
                        style: TextStyle(
                            color: Color(0xff1060D7),
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Center(
                    child: ListTile(
                      leading: Container(
                        width: 67,
                        height: 56,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffE4ECFE)),
                        child: Icon(
                          Icons.call,
                          color: Color(0xff1060D7),
                        ),
                      ),
                      title: Text(
                        "Voice call",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Can messaging with Doctor",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "\$10",
                        style: TextStyle(
                            color: Color(0xff1060D7),
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 6,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Center(
                    child: ListTile(
                      leading: Container(
                        width: 67,
                        height: 56,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Color(0xffE4ECFE)),
                        child: Icon(
                          Icons.video_call,
                          color: Color(0xff1060D7),
                        ),
                      ),
                      title: Text(
                        "Video call",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Can messaging with Doctor",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: Text(
                        "\$10",
                        style: TextStyle(
                            color: Color(0xff1060D7),
                            fontSize: 22,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (builder) => PaitnetsDetails(
                        //               id: FirebaseAuth
                        //                   .instance.currentUser!.uid,
                        //             )));
                      },
                      child: Text('Book Appointment'),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          primary: Color(0xfff0092E1),
                          fixedSize: Size(330, 50))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
