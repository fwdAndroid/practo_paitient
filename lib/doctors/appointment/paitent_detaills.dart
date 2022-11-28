import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practo_paitient/bottom.dart';
import 'package:practo_paitient/database/databasemethods.dart';
import 'package:practo_paitient/doctors/appointment/medical_records.dart';
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
                            "Phone Number:",
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
                              controller: phoneController,
                              decoration: InputDecoration(
                                hintText: 'phoneNumber',
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
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: TextField(
                        controller:
                            timeController, //editing controller of this TextField
                        decoration: InputDecoration(
                            icon: Icon(Icons.timer), //icon of text field
                            hintText: "Enter Time" //hint text of field
                            ),
                        readOnly:
                            true, //set it true, so that user will not able to edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            initialTime: TimeOfDay.now(),
                            context: context,
                          );

                          if (pickedTime != null) {
                            print(pickedTime.format(context)); //output 10:51 PM
                            DateTime parsedTime = DateFormat.jm()
                                .parse(pickedTime.format(context).toString());
                            //converting to DateTime so that we can further format on different pattern.
                            print(parsedTime); //output 1970-01-01 22:53:00.000
                            String formattedTime =
                                DateFormat('HH:mm:ss').format(parsedTime);
                            print(formattedTime); //output 14:59:00
                            //DateFormat() is from intl package, you can format the time on any pattern you need.

                            setState(() {
                              timeController.text =
                                  formattedTime; //set the value of text field.
                            });
                          } else {
                            print("Time is not selected");
                          }
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Center(
                      child: TextField(
                        controller: dateController,
                        //editing controller of this TextField
                        decoration: InputDecoration(
                            icon:
                                Icon(Icons.calendar_today), //icon of text field
                            hintText: "Select Date" //hint text of field
                            ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateController.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Center(
                      child: Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: ElevatedButton(
                            onPressed: makeAppointment,
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

  void makeAppointment() async {
    setState(() {
      _isLoading = true;
    });
    String res = await DatabaseMethods().makeAppointment(
        time: timeController.text,
        date: dateController.text,
        problem: problem.text,
        age: age.text,
        name: nameController.text,
        gender: genderController.text,
        phoneNumber: phoneController.text,
        uid: FirebaseAuth.instance.currentUser!.uid,
        doctorId: widget.id,
        doctorName: widget.doctorName
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
          builder: (builder) => MedicalRecords(),
        ),
      );
    } else {
      showSnakBar(res, context);
    }
  }
}
