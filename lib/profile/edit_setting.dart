import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practo_paitient/database/databasemethods.dart';
import 'package:practo_paitient/widgets/utils.dart';

class Edit_Setting extends StatefulWidget {
  const Edit_Setting({Key? key}) : super(key: key);

  @override
  _Edit_SettingState createState() => _Edit_SettingState();
}

class _Edit_SettingState extends State<Edit_Setting> {
  final TextEditingController emailContoller = TextEditingController();
  final TextEditingController addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Uint8List? _image;

  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailContoller.clear();
    addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final inputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            "Edit Paitent Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return new CircularProgressIndicator();
                }
                var document = snapshot.data;
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: NetworkImage(document['photoURL']),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Text(
                          document['name'],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.email),
                          fillColor: Colors.white,
                          labelText: document['email'],
                          hintText: 'Email',
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        controller: emailContoller,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          suffixIcon: Icon(Icons.local_hospital),
                          fillColor: Colors.white,
                          hintText: 'Address',
                          labelText: document['address'],
                          border: inputBorder,
                          focusedBorder: inputBorder,
                          enabledBorder: inputBorder,
                          filled: true,
                          contentPadding: EdgeInsets.all(8),
                        ),
                        keyboardType: TextInputType.text,
                        controller: addressController,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xfff0092E1).withOpacity(.6),
                            fixedSize: const Size(350, 30),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          onPressed: () {},
                          child: _isLoading == true
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : Text(
                                  'Update',
                                  style: GoogleFonts.getFont('Montserrat',
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontStyle: FontStyle.normal),
                                ),
                        ),
                      ),
                    ]);
              }),
        ));
  }

  // profileUpdates() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   String rse = await DatabaseMethods().profileUpdate(

  //     doctorEmail: doctoremailController.text,
  //     doctorAddres: doctorAddressController.text,
  //     doctorHospital: doctorHospitalNameController.text,
  //   );

  //   print(rse);
  //   setState(() {
  //     _isLoading = false;
  //   });
  //   if (rse == 'success') {
  //     showSnakBar(rse, context);
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (builder) => MobileScreenLayout()));
  //   } else {
  //     showSnakBar(rse, context);
  //   }
  // }
}
