import 'package:flutter/material.dart';
import 'package:practo_paitient/hospitals/hospital_detail.dart';

class Hospital_Appointment extends StatefulWidget {
  String? id;
  String? address;
  String? name;
  String? email;
  Hospital_Appointment(
      {super.key, this.address, this.id, this.name, this.email});

  @override
  State<Hospital_Appointment> createState() => _Hospital_AppointmentState();
}

class _Hospital_AppointmentState extends State<Hospital_Appointment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Text(
          widget.name!,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("asset/splash.png"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "About Hospital",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.name!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Address",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.address!,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 14),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Hospital_Details(
                                      id: widget.id,
                                      hospitalName: widget.name,
                                    )));
                      },
                      child: Text('Make Appointment'),
                      style: ElevatedButton.styleFrom(
                          shape: StadiumBorder(),
                          backgroundColor: Color(0xfff0092E1),
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
