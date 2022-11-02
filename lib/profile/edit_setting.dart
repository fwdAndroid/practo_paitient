import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:practo_paitient/bottom.dart';
import 'package:practo_paitient/database/databasemethods.dart';
import 'package:practo_paitient/widgets/utils.dart';

class Edit_Setting extends StatefulWidget {
  const Edit_Setting({Key? key}) : super(key: key);

  @override
  _Edit_SettingState createState() => _Edit_SettingState();
}

class _Edit_SettingState extends State<Edit_Setting> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController doctorDateofBirthContorller =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  Uint8List? _image;

  bool _isLoading = false;
  var items = [
    'Male',
    'Female',
  ];
  String dropdownvalue = 'Male';
  final ImagePicker _picker = ImagePicker();
  File? imageUrl;
  String imageLink = "";
  void getImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageUrl = File(image!.path);
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.clear();
    _nameController.clear();
    _addressController.clear();
    doctorDateofBirthContorller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Row(
                          children: [
                            Image.asset("asset/Vector.png"),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Edit Setting",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => selectImage(),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: 374,
                            height: 157,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Color(0xffD2D2D2),
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _image != null
                                    ? CircleAvatar(
                                        radius: 60,
                                        backgroundImage: MemoryImage(_image!))
                                    : Image.asset(
                                        "asset/cam.png",
                                        width: 51,
                                        height: 39,
                                      ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Update photo',
                                      style: GoogleFonts.getFont(
                                        'Montserrat',
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      children: <TextSpan>[
                                        TextSpan(
                                            text: '*',
                                            style: GoogleFonts.getFont(
                                              'Montserrat',
                                              fontWeight: FontWeight.w500,
                                              color: Colors.red,
                                              fontStyle: FontStyle.normal,
                                            )),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Update Full Name ',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(

                          // height: 60,
                          margin: EdgeInsets.only(top: 5, left: 15, right: 15),

                          //  padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.circular(30),
                              border: Border.all(color: Color(0xffD2D2D2))),
                          // border: Border.all(color: Colors.grey,width: 0.5)

                          child: TextFormField(
                            controller: _nameController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Please Enter username..\ ";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: document['name'],
                              contentPadding: EdgeInsets.only(left: 20),
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.getFont('Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff8D8989),
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Email',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(

                          // height: 60,
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),

                          //  padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.circular(30),
                              border: Border.all(
                                color: Color(0xff8D8989),
                              )),
                          // border: Border.all(color: Colors.grey,width: 0.5)

                          child: TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            // //  textAlign: TextAlign.start,
                            controller: _emailController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Please Enter email..\ ";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: document['email'],
                              contentPadding: EdgeInsets.only(
                                left: 20,
                              ),
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.getFont('Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff8D8989),
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal),
                            ),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Gender',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 15, right: 15),

                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: Color(0xff8D8989))),
                        // margin: EdgeInsets.only(left: 25, right: 15),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: DropdownButton(
                            isExpanded: true,
                            underline: SizedBox(),
                            // Initial Value
                            value: dropdownvalue,

                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),

                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(document['gender']),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Date of Birth',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(15),
                          height: 80,
                          child: Center(
                              child: TextField(
                            controller: doctorDateofBirthContorller,
                            //editing controller of this TextField
                            decoration: InputDecoration(
                                icon: Icon(
                                    Icons.calendar_today), //icon of text field
                                labelText: document['dob'] //label text of field
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
                                  doctorDateofBirthContorller.text =
                                      formattedDate; //set output date to TextField value.
                                });
                              } else {}
                            },
                          ))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: RichText(
                          text: TextSpan(
                            text: 'Address',
                            style: GoogleFonts.getFont(
                              'Montserrat',
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16,
                              fontStyle: FontStyle.normal,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                  text: '*',
                                  style: GoogleFonts.getFont(
                                    'Montserrat',
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red,
                                    fontSize: 12,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                      ),
                      Container(

                          // height: 60,
                          margin: EdgeInsets.only(top: 10, left: 15, right: 15),

                          //  padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.circular(30),
                              border: Border.all(color: Color(0xff8D8989))),
                          // border: Border.all(color: Colors.grey,width: 0.5)

                          child: TextFormField(
                            //  textAlign: TextAlign.start,
                            controller: _addressController,
                            validator: (v) {
                              if (v!.isEmpty) {
                                return " Please Enter Address..\ ";
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: document['gender'],
                              contentPadding: EdgeInsets.only(
                                left: 20,
                              ),
                              border: InputBorder.none,
                              hintStyle: GoogleFonts.getFont('Montserrat',
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff8D8989),
                                  fontSize: 15,
                                  fontStyle: FontStyle.normal),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xfff0092E1).withOpacity(.6),
                            fixedSize: const Size(350, 60),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                          onPressed: Edit_Setting,
                          child: _isLoading == true
                              ? const Center(
                                  child: CircularProgressIndicator.adaptive(),
                                )
                              : Text(
                                  'Confrim',
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

  // Select Image From Gallery
  selectImage() async {
    Uint8List ui = await pickImage(ImageSource.gallery);
    setState(() {
      _image = ui;
    });
  }

  Edit_Setting() async {
    setState(() {
      _isLoading = true;
    });
    String rse = await DatabaseMethods().profileDetail(
      dob: doctorDateofBirthContorller.text,
      email: _emailController.text,
      name: _nameController.text,
      address: _addressController.text,
      file: _image!,
      gender: dropdownvalue,
      uid: FirebaseAuth.instance.currentUser!.uid,
    );

    print(rse);
    setState(() {
      _isLoading = false;
    });
    if (rse == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (builder) => MobileScreenLayout(),
        ),
      );
    } else {
      showSnakBar(rse, context);
    }
  }
}
