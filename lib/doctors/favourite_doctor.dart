import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class FavouriteDoctor extends StatefulWidget {
  final String? photorul;
  final String? doctorName;
  final String? doctorDescription;
  FavouriteDoctor(
      {Key? key, this.doctorDescription, this.photorul, this.doctorName})
      : super(key: key);

  @override
  State<FavouriteDoctor> createState() => _FavouriteDoctorState();
}

class _FavouriteDoctorState extends State<FavouriteDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "Favourite Doctor",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("doctorsprofile").where(
              'likes',
              isEqualTo: [FirebaseAuth.instance.currentUser!.uid]).snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (BuildContext ctx, index) {
                  Map<String, dynamic> snap =
                      snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  return InkWell(
                    onTap: () {},
                    child: Container(
                        width: MediaQuery.of(context).size.height,
                        child: Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                snap['doctorPhotoURL'],
                              ),
                            ),
                            title: SizedBox(
                              child: Text(
                                snap['doctorName'],
                                style: GoogleFonts.getFont(
                                  'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            subtitle: SizedBox(
                              child: Text(
                                snap['doctorDesc'],
                                style: GoogleFonts.getFont(
                                  'Rubik',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xff000000),
                                ),
                              ),
                            ),
                            trailing: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                        )),
                  );
                });
          }),
    );
  }
}
