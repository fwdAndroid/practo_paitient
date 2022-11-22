import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:practo_paitient/doctors/appointment/doctor_appointment.dart';

class Specialist_Doctor extends StatefulWidget {
  const Specialist_Doctor({Key? key}) : super(key: key);

  @override
  State<Specialist_Doctor> createState() => _Specialist_DoctorState();
}

class _Specialist_DoctorState extends State<Specialist_Doctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream:
          FirebaseFirestore.instance.collection("doctorsprofile").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (builder) => Doctor_Appointment(
                              experience: data['experience'],
                              id: data['uid'],
                              name: data['doctorName'],
                              specialization: data['doctorSpecialization'],
                              image: data['doctorPhotoURL'],
                              address: data['doctorAddres'],
                              images: data['doctorCertificationImages'],
                              description: data['doctorDesc'])));
                },
                leading: CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                    data['doctorPhotoURL'],
                  ),
                ),
                title: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Name',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        data['doctorName'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                subtitle: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        'Specialization',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        data['doctorSpecialization'],
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    ));
  }
}
