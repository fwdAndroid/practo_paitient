import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/database/storage_methods.dart';
import 'package:practo_paitient/models/appointment_model.dart';
import 'package:practo_paitient/models/profile_model.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:uuid/uuid.dart';

class DatabaseMethods {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

//Add Google
  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

//OTP Number Add
  Future<String> numberAdd() async {
    String res = 'Some error occured';
    try {
      //Add User to the database with modal
      ProfileModel userModel = ProfileModel(
        dob: '',
        gender: '',
        name: '',
        uid: FirebaseAuth.instance.currentUser!.uid,
        email: '',
        address: '',
        phoneNumber: FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
        photoURL: '',
      );
      await firebaseFirestore
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(
            userModel.toJson(),
          );
      res = 'success';
      debugPrint(res);
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  //Profile Details
  Future<String> profileDetail({
    required String email,
    required String uid,
    required String name,
    required String address,
    required String gender,
    required String dob,
    required String phoneNumber,
    required Uint8List file,
  }) async {
    String res = 'Some error occured';

    try {
      if (email.isNotEmpty || name.isNotEmpty) {
        String photoURL = await StorageMethods()
            .uploadImageToStorage('ProfilePics', file, false);
        //Add User to the database with modal

        ProfileModel userModel = ProfileModel(
          dob: dob,
          gender: gender,
          name: FirebaseAuth.instance.currentUser!.displayName ?? name,
          address: address,
          uid: FirebaseAuth.instance.currentUser!.uid,
          email: FirebaseAuth.instance.currentUser!.email ?? email,
          phoneNumber: phoneNumber ??
              FirebaseAuth.instance.currentUser!.phoneNumber.toString(),
          photoURL: FirebaseAuth.instance.currentUser!.photoURL ?? photoURL,
        );
        await firebaseFirestore
            .collection('users')
            .doc(uid)
            .update(userModel.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  void updateMedicalRecoders(
      BuildContext context, String messageId, String medicalRecordes) async {
    try {
      await firebaseFirestore
          .collection('appointments')
          .doc("details")
          .collection(FirebaseAuth.instance.currentUser!.uid)
          .doc(messageId)
          .update({'medicalRecordsImages': medicalRecordes});
    } catch (e) {}
  }

  var ss = Uuid().v1();

  //Appointment
  Future<String> makeAppointment({
    required name,
    required age,
    required problem,
    required gender,
    required date,
    required time,
    required phoneNumber,
    required doctorId,
    required uid,
    required doctorName
  }) async {
    String res = 'Some error occured';

    try {
      if (gender.isNotEmpty || date.isNotEmpty || age) {
        Appointmentmodel userModel = Appointmentmodel(
          id: uid,
          doctorid: doctorId.toString(),
          name: name.toString(),
          status: "pending",
          age: age.toString(),
          problem: problem.toString(),
          date: date.toString(),
          time: time.toString(),
          doctorName: doctorName.toString(),
          phoneNumber: phoneNumber.toString(),
        );

        var dooc = Uuid().v1();
        await firebaseFirestore
            .collection('appointments')
            .doc("details")
            .collection("records")
            .doc(dooc)
            .set(userModel.toJson());
        res = 'success';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
