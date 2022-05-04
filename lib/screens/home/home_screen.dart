import 'dart:ui';

import 'package:pro_recovery/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pro_recovery/models/RecommendDoctor.dart';
// import 'package:pro_recovery/screens/doctors/doctors_screen.dart';
import 'package:pro_recovery/screens/patients/patients_screen.dart';

import 'components/available_doctors.dart';
import 'components/categories.dart';
import '../../components/custom_app_bar.dart';
import 'components/recommended_doctor_card.dart';
import 'components/recommended_doctors.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(108, 216, 209, 1),
        title: Text(
          "Pro Recovery",
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.menu))],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: defaultPadding)),
            Text('Выбранный пациент',
                textAlign: TextAlign.start, style: TextStyle(fontSize: 20)),
            Padding(padding: EdgeInsets.only(top: defaultPadding)),

            // CustomAppBar(
            //   text: "Find Your",
            //   title: "Specialist",
            // ),
            GestureDetector(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => PatientsScreen(),
                ),
              ),
              child: AspectRatio(
                aspectRatio: 2.5,
                child: RecommendDoctorCard(
                  doctor: demo_recommended_doctor[1],
                ),
              ),
            ),

            Categories(),
            //AvailableDoctors()
          ],
        ),
      ),
    );
  }
}
