import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:practo_paitient/doctors/appointment/confrim_appointment.dart';
import 'package:practo_paitient/doctors/appointment/paitent_detaills.dart';
import 'package:practo_paitient/doctors/favourite_doctor.dart';

class Doctor_Appointment extends StatefulWidget {
  String? id;
  String? image;
  String? name;
  String? specialization;
  String? description;
  String? experience;
  String? address;
  String? doctorName;
  List<dynamic>? images;

  Doctor_Appointment(
      {Key? key,
      this.id,
      this.image,
      this.specialization,
      this.name,
      this.experience,
      this.address,
      this.images,
      this.description})
      : super(key: key);

  @override
  State<Doctor_Appointment> createState() => _Doctor_AppointmentState();
}

class _Doctor_AppointmentState extends State<Doctor_Appointment> {
  DateTime dateTime = DateTime.now();
  var ispressed;
  var sss;
  int days = 10;
  @override
  Widget build(BuildContext context) {
    var snapsl;
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
          actions: [
            //   IconButton(
            //       icon: Icon(Icons.favorite_border,
            //           color: ispressed ? Color(0xff1060D7) : Colors.green),
            //       onPressed: () async {
            //         await FirebaseFirestore.instance
            //             .collection("doctorsprofile")
            //             .doc(snapsl.id)
            //             .update({"like": true}).whenComplete(() => {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (builder) => FavouriteDoctor()))
            //                 });
            //       }),
            // ],]
          ]),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 2,
                  child: ListTile(
                      leading: Image.network(
                        widget.image!,
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.name!,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          RatingBarIndicator(
                            rating: 8.2,
                            itemCount: 5,
                            itemSize: 18.0,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        widget.specialization!,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      )),
                ),
              ),
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
                                widget.experience!,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "About Doctor",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.description!,
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
                "Doctor Specialization",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.specialization!,
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Doctor Certificates",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            Container(
              height: 210,
              padding: EdgeInsets.all(4),
              child: GridView.builder(
                  itemCount: widget.images!.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return Container(
                      height: 210,
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                              image: NetworkImage(widget.images![index]),
                              fit: BoxFit.cover)),
                    );
                  }),
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
                                builder: (builder) => PaitnetsDetails(
                                      id: widget.id,
                                      doctorName: widget.name,
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
