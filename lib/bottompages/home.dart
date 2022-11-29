import 'package:flutter/material.dart';
import 'package:practo_paitient/doctors/favourite_doctor.dart';
import 'package:practo_paitient/doctors/specialist_doctor.dart';
import 'package:practo_paitient/hospitals/hospitals_list.dart';
import 'package:practo_paitient/notification/notifications.dart';

class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              "asset/Vector.png",
              width: 34,
              height: 34,
            ),
          ),
          title: Text(
            'Practo',
            style: TextStyle(
                fontWeight: FontWeight.w600, fontSize: 22, color: Colors.black),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => Notifications()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffE4ECFE),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(
                      Icons.notifications,
                      color: Color(0xff1060D7),
                    )),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (builder) => FavouriteDoctor()));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    // margin: EdgeInsets.symmetric(horizontal: 10),
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Color(0xffE4ECFE),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Color(0xff1060D7),
                      // size: 15,
                    )),
              ),
            )
          ],
        ),
        body: Form(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: TextField(
                  autofocus: false,
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green),
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Search',
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.only(
                        left: 14.0, bottom: 6.0, top: 8.0),
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Specialist_Doctor()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 154,
                          height: 221,
                          decoration: BoxDecoration(
                              color: Color(0xff4887FE),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("asset/teeth.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Doctors",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "221 Doctors",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                         Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => HospitalList()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 154,
                          height: 225,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 196, 25, 25),
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child:
                                      Image.asset("asset/hospital-building.png"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Hospitals",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "21 Hospitals",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.white),
                                  ),
                                ),
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Top Doctors",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w600),
                    ),
                    TextButton(onPressed: () {}, child: Text("See All"))
                  ],
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.3,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xffD2D2D2)),
                          width: 150,
                          height: 182,
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  "asset/doctor.png",
                                  fit: BoxFit.cover,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Dr.Shang chi",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    "Cardio Spacialist",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: Colors.black),
                                  ),
                                ),
                              ]),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
