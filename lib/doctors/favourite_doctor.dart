import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FavouriteDoctor extends StatefulWidget {
  const FavouriteDoctor({Key? key}) : super(key: key);

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
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(4.0),
          child: Card(
            child: ListTile(
                leading: Image.asset("asset/doctor.png"),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Dr.Shang chi",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    RatingBarIndicator(
                      rating: 8.2,
                      itemCount: 5,
                      itemSize: 18.0,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                ),
                trailing: Padding(
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
                subtitle: Text(
                  "Cardio Spacialist: Smithy London Hospital",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
                )),
          ),
        );
      }),
    );
  }
}
