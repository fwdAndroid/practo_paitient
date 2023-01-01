import 'package:practo_paitient/bottompages/appointment.dart';
import 'package:practo_paitient/bottompages/chats/widgets/all_doctor_chat.dart';

import 'package:flutter/material.dart';
import 'package:practo_paitient/bottompages/doctor_appointment.dart';
import 'package:practo_paitient/notification/doctor_notifications.dart';
import 'package:practo_paitient/notification/notifications.dart';

class MainNotificationAppointment extends StatefulWidget {
  MainNotificationAppointment({
    Key? key,
  }) : super(key: key);

  @override
  State<MainNotificationAppointment> createState() =>
      _MainNotificationAppointmentState();
}

class _MainNotificationAppointmentState
    extends State<MainNotificationAppointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Image.asset(
              "asset/splash.png",
              height: 300,
            ),
            SizedBox(
              height: 15,
            ),
            // ignore: prefer_const_constructors
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => Notifications()));
                  },
                  // ignore: prefer_const_constructors
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("asset/hospital-building.png"),
                  ),
                  title: Text("Hospitals Notifications"),
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),

            // ignore: prefer_const_constructors
            Container(
              margin: EdgeInsets.only(left: 20, right: 20),
              child: Card(
                child: ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => DoctorNotifications()));
                  },
                  // ignore: prefer_const_constructors
                  leading: CircleAvatar(
                    backgroundImage: AssetImage("asset/teeth.png"),
                  ),
                  title: Text("Doctors Notifications"),
                ),
              ),
            ),
            // AllChats(
            //   doctorid: widget.doctorid,
            //   name: widget.name,
            //   userid: widget.userid,
            // ),
          ],
        ),
      ),
    );
  }
}
