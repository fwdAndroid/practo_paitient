import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Appointment_Detail extends StatefulWidget {
  const Appointment_Detail({Key? key}) : super(key: key);

  @override
  State<Appointment_Detail> createState() => _Appointment_DetailState();
}

class _Appointment_DetailState extends State<Appointment_Detail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Appointment',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Card(
            child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Appointment_Detail()));
                },
                leading: Image.asset("asset/doctor.png"),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr.Shang chi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    RichText(
                      // Controls visual overflow
                      overflow: TextOverflow.clip,

                      // Controls how the text should be aligned horizontally
                      textAlign: TextAlign.end,

                      // Control the text direction
                      textDirection: TextDirection.rtl,

                      // Whether the text should break at soft line breaks
                      softWrap: true,

                      // Maximum number of lines for the text to span
                      maxLines: 1,

                      // The number of font pixels for each logical pixel
                      textScaleFactor: 1,
                      text: TextSpan(
                        text: 'Messaging  ',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Scheduled',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff1060D7))),
                        ],
                      ),
                    )
                  ],
                ),
                trailing: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                      // margin: EdgeInsets.symmetric(horizontal: 10),
                      width: 50,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Color(0xffE4ECFE),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Icon(
                        Icons.call,
                        color: Color(0xff1060D7),
                        // size: 15,
                      )),
                ),
                subtitle: Text(
                  "13:00-13:30 PM",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                )),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 150,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Color(0xff1060D7))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 67,
                              height: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffE4ECFE)),
                              child: Icon(
                                Icons.person_search,
                                color: Color(0xff1060D7),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "33000",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1060D7),
                              ),
                            ),
                            Text(
                              "Paitents",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 67,
                              height: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffE4ECFE)),
                              child: Icon(
                                Icons.person,
                                color: Color(0xff1060D7),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "15+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1060D7),
                              ),
                            ),
                            Text(
                              "Year Experience",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              width: 67,
                              height: 56,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffE4ECFE)),
                              child: Icon(
                                Icons.bubble_chart,
                                color: Color(0xff1060D7),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "15+",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff1060D7),
                              ),
                            ),
                            Text(
                              "Reviews",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  )),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Visit Time",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Morning",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Monday,March 24 2022",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "13:00-13:30 PM",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Patient Information",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Full Name:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Fawad Kaleem",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Age:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "            19",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Phone:",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "       +62678-4678-6578",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Fee Information",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w800),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "\$16 (Paid)",
              style: TextStyle(
                  color: Color(0xff1060D7),
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: ElevatedButton(
              onPressed: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (builder) => ContinuePhone()));
              },
              child: Text(
                "Message Now (Start 10:00AM)",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Color(0xff1060D7).withOpacity(.5),
                  fixedSize: Size(374, 60),
                  shape: StadiumBorder()),
            ),
          ),
        ],
      ),
    );
  }
}
