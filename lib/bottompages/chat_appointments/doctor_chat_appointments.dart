import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practo_paitient/bottompages/chat_appointments/past_chat.dart';
import 'package:practo_paitient/bottompages/chats/widgets/all_doctor_chat.dart';

class DoctorChatAppointment extends StatefulWidget {
  const DoctorChatAppointment({super.key});

  @override
  State<DoctorChatAppointment> createState() => _DoctorChatAppointmentState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _DoctorChatAppointmentState extends State<DoctorChatAppointment>
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
              text: 'Current Chat',
            ),
            Tab(
              text: 'Past Chat',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          AllDoctorChat(),
          PastDoctor(),
        ],
      ),
    );
  }
}
