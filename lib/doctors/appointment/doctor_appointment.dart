import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/doctors/appointment/paitent_detaills.dart';
import 'package:practo_paitient/doctors/favourite_doctor.dart';

class DoctorAppointment extends StatefulWidget {
  String id;
  String experience;
  final likes;
  String specialization;
  String name;
  String image;
  String description;
  String address;
  List<dynamic>? images;
  DoctorAppointment(
      {super.key,
      required this.specialization,
      this.images,
      required this.id,
      required this.address,
      required this.image,
      required this.experience,
      required this.likes,
      required this.description,
      required this.name});

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
}

class _DoctorAppointmentState extends State<DoctorAppointment> {
  @override
  Widget build(BuildContext context) {
    print(widget.id);
    print(widget.experience);
    print(widget.address);
    print(widget.description);
    print(widget.specialization);
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            widget.name,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection("doctorsprofile")
                    .doc(widget.id)
                    .update({
                  "likes": FieldValue.arrayUnion(
                      [FirebaseAuth.instance.currentUser!.uid])
                }).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => FavouriteDoctor(
                                photorul: widget.image,
                                doctorDescription: widget.description,
                                doctorName: widget.name,
                              )));
                });
              },
              icon: Icon(
                Icons.favorite_outline_outlined,
                color: Colors.blue,
              ),
            )
          ]
          // IconButton(onPressed: (){}, child: Text("data"))
          // LikeAnimation(
          //   smallLike: true,
          //   isAnimating:
          //       widget.likes.contains(FirebaseAuth.instance.currentUser!.uid),
          //   child: IconButton(
          //     onPressed: () async {

          //     },
          //     icon: widget.likes
          //             .contains(FirebaseAuth.instance.currentUser!.uid)
          //         ? Icon(
          //             Icons.favorite,
          //             color: Colors.red,
          //           )
          //         : Icon(
          //             Icons.favorite,
          //             color: Colors.black,
          //           ),
          //   ),
          // )
          ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                            widget.experience,
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
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.description,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Doctor Specialization",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.specialization,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Address",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget.address,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 14),
            textAlign: TextAlign.justify,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Doctor Certificates",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Container(
          height: 210,
          padding: EdgeInsets.all(4),
          child: GridView.builder(
              itemCount: widget.images!.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
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
      ]),
    );
  }
}
