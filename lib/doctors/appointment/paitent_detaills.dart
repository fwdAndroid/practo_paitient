import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practo_paitient/bottom.dart';
import 'package:practo_paitient/database/databasemethods.dart';
import 'package:practo_paitient/doctors/appointment/medical_records.dart';
import 'package:practo_paitient/doctors/appointment/time_selection.dart';
import 'package:practo_paitient/payment/payment.dart';
import 'package:practo_paitient/widgets/utils.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class PaitnetsDetails extends StatefulWidget {
  final id;
  final doctorName;
  PaitnetsDetails({Key? key, required this.id, required this.doctorName})
      : super(key: key);

  @override
  State<PaitnetsDetails> createState() => _PaitnetsDetailsState();
}

class _PaitnetsDetailsState extends State<PaitnetsDetails> {
  TextEditingController age = TextEditingController();
  TextEditingController problem = TextEditingController();
  TextEditingController timeinput = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  bool _isLoading = false;
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  /// This has to happen only once per app
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  /// Each time to start a speech recognition session
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    _speechToText.isListening;

    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          "My Details",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("doctorsprofile")
              .doc(widget.id)
              .snapshots(),
          builder: (context, AsyncSnapshot snapshot) {
            var snap = snapshot.data;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Full Name",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: "Enter Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Paitent Age",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      controller: age,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Enter Age',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "Gender:",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: TextField(
                              controller: genderController,
                              decoration: InputDecoration(
                                hintText: 'Gender',
                                hintStyle: TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                ),
                              ),
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      "Write Your Problem:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: TextFormField(
                      controller: problem,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              _startListening();

                              setState(() {
                                problem.text = _lastWords;
                              });
                            },
                            icon: Icon(_speechToText.isNotListening
                                ? Icons.mic_off
                                : Icons.mic)),
                        hintText: 'Write Your Problem',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                            onPressed: doctormakeAppointment,
                            child: _isLoading == true
                                ? const Center(
                                    child: CircularProgressIndicator.adaptive(),
                                  )
                                : Text('Continue'),
                            style: ElevatedButton.styleFrom(
                                shape: StadiumBorder(),
                                primary: Color(0xfff0092E1),
                                fixedSize: Size(330, 50))),
                      ),
                    ),
                  ),
                ]);
          }),
    );
  }

  void doctormakeAppointment() async {
    setState(() {
      _isLoading = true;
    });
    String res = await DatabaseMethods().doctormakeAppointment(
      time: timeController.text,
      date: dateController.text,
      problem: problem.text,
      doctorid: widget.id,
      age: age.text,
      name: nameController.text,
      gender: genderController.text,
      uid: FirebaseAuth.instance.currentUser!.uid,

      // medicalRecords: []
      // doctorid: FirebaseFirestore.instance
      //     .collection("doctorProfile")
      //     .doc(FirebaseAuth.instance.currentUser!.uid)
    );

    print(res);
    setState(() {
      _isLoading = false;
    });
    if (res == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => TimeSelction(
            id: widget.id,
          ),
        ),
      );
    } else {
      showSnakBar(res, context);
    }
  }
}
