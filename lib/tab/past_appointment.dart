import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_paitient/bottompages/appointment.dart';
class Past extends StatefulWidget {
  const Past({Key? key}) : super(key: key);

  @override
  State<Past> createState() => _PastState();
}

class _PastState extends State<Past> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                autofocus: false,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green),
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Search',
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      const EdgeInsets.only(left: 14.0, bottom: 6.0, top: 8.0),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Card(
                    child: ListTile(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (builder) => Appointment_Detail()));
                        },
                        leading: Image.asset("asset/doctor.png"),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Dr.Shang chi",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
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
                                style: DefaultTextStyle.of(context).style,
                                children: const <TextSpan>[
                                  TextSpan(
                                      text: 'Completed',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff55C07E))),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Icon(
                                Icons.call,
                                color: Color(0xff1060D7),
                                // size: 15,
                              )),
                        ),
                        subtitle: Text(
                          "13:00-13:30 PM",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12),
                        )),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
