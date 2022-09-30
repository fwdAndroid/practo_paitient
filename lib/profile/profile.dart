import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:practo_paitient/bottom.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _usernameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _refreralController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  Uint8List? _image;

  bool _isLoading = false;
  var items = [
    'Male',
    'Female',
  ];
  String dropdownvalue = 'Male';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                      "Profile",
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 374,
                  height: 117,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Color(0xffD2D2D2),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "asset/cam.png",
                        width: 51,
                        height: 39,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Upload photo profile",
                        style: TextStyle(color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Full Name',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
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
                    validator: (v) {
                      if (v!.isEmpty) {
                        return " Please Enter username..\ ";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Adam Smith',
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
                child: Text(
                  'Email',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
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
                    // //  textAlign: TextAlign.start,
                    // controller: _usernameController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return " Please Enter username..\ ";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'adam.smith@yourdomain.com',
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
                child: Text(
                  'Gender',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
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
                        child: Text(items),
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
                child: Text(
                  'Address',
                  style: GoogleFonts.getFont(
                    'Montserrat',
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
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
                    // controller: _usernameController,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return " Please Enter username..\ ";
                      }

                      return null;
                    },
                    decoration: InputDecoration(
                      hintText: 'Los Angles',
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
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (builder) => MobileScreenLayout()));
                  },
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
            ]));
  }
}
