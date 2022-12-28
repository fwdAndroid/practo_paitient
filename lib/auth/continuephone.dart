import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:phone_form_field/phone_form_field.dart';
import 'package:practo_paitient/auth/verifyphone.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:practo_paitient/bottom.dart';
import 'package:practo_paitient/database/databasemethods.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ContinuePhone extends StatefulWidget {
  const ContinuePhone({Key? key}) : super(key: key);

  @override
  State<ContinuePhone> createState() => _ContinuePhoneState();
}

class _ContinuePhoneState extends State<ContinuePhone> {
  final formKey = GlobalKey<FormState>();
  int? isviewed;

  String dialCodeDigits = "+92";
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PhoneController controller;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "asset/splash.png",
                width: 150,
                height: 200,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "OTP Verification",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                "We will send you a code for verification dont share \n anyone your code",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueAccent),
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white70),
                margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Row(
                  children: [
                    CountryCodePicker(
                        onChanged: (country) {
                          setState(() {
                            dialCodeDigits = country.dialCode!;
                          });
                        },
                        initialSelection: "PK",
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        favorite: ["+92", "PAK"]),
                    Expanded(
                      child: Container(
                        child: TextFormField(
                          validator: RequiredValidator(errorText: "Required"),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "3070684743",
                            //  prefix: Padding(padding: EdgeInsets.all(10),child: Text(dialCodeDigits,style: TextStyle(color: Colors.black),),),
                          ),
                          keyboardType: TextInputType.number,
                          controller: _controller,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => VerifyPhone(
                                    codeDigits: dialCodeDigits,
                                    phone: _controller.text)));
                        //  isviewed != 0 ? OnBoard() : Home(),     Navigator.push(
                        //           context,
                        //           MaterialPageRoute(
                        //               builder: (builder) => VerifyPhone(
                        //                   )));

                        // isviewed != 0
                        //     ? VerifyPhone(
                        //         codeDigits: dialCodeDigits,
                        //         phone: _controller.text)
                        //     : MobileScreenLayout();
                      }
                    },
                    child: Text('Get OTP'),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        primary: Color(0xff1060D7).withOpacity(.5),
                        fixedSize: Size(300, 46))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
