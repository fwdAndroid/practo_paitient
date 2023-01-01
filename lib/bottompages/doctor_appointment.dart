import 'package:flutter/material.dart';
import 'package:practo_paitient/tab/doctor_current_appointment.dart';
import 'package:practo_paitient/tab/doctor_past_appointment.dart';
import 'package:practo_paitient/tab/doctor_pending_appointment.dart';

class DoctorAppointment extends StatefulWidget {
  const DoctorAppointment({super.key});

  @override
  State<DoctorAppointment> createState() => _DoctorAppointmentState();
}

/// AnimationControllers can be created with `vsync: this` because of TickerProviderStateMixin.
class _DoctorAppointmentState extends State<DoctorAppointment>
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
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'My DoctorAppointment',
          style: TextStyle(color: Colors.black),
        ),
        bottom: TabBar(
          indicatorColor: Colors.blue,
          labelColor: Colors.black,
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: 'Upcoming',
            ),
            Tab(
              text: 'Past',
            ),
            Tab(
              text: 'Pending',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const <Widget>[
          CurrentAppointment(),
          DoctorPastAppointment(),
          DoctorPendingAppointment()
        ],
      ),
    );
  }
}
