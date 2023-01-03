import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/bottompages/chat_appointments/hospital_past_chat.dart';
import 'package:practo_paitient/bottompages/chat_appointments/past_chat.dart';
import 'package:practo_paitient/bottompages/chats/widgets/all_doctor_chat.dart';
import 'package:practo_paitient/bottompages/chats/widgets/widgets.dart';

class HospitalChatAppointment extends StatefulWidget {
  const HospitalChatAppointment({super.key});

  @override
  State<HospitalChatAppointment> createState() =>
      _HospitalChatAppointmentState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _HospitalChatAppointmentState extends State<HospitalChatAppointment>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Chat',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Current Hospital Chat',
            ),
            Tab(
              text: 'Past Hospital Chat',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AllHospitalChat(),
          HospitalPasChat(),
        ],
      ),
    );
  }
}
