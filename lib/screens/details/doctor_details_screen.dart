import 'package:pro_recovery/components/heightlight.dart';
import 'package:pro_recovery/components/rating.dart';
import 'package:pro_recovery/constants.dart';
import 'package:pro_recovery/screens/appointment/appointment_screen.dart';
import 'package:flutter/material.dart';

import 'components/communication.dart';

class DoctorDetailsScreen extends StatelessWidget {
  const DoctorDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(108, 216, 209, 1),
        title: Text("Alla Ivanova"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UserInfo(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: Communication(),
              ),
              Text(
                "Булимия",
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: defaultPadding),
              Text(
                "Пациент был приглашен 25.04.22",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              SizedBox(height: defaultPadding),
              Text(
                "Общая информация от пациента",
                style: Theme.of(context).textTheme.subtitle2,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: defaultPadding / 2),
                child: Text(
                  "",
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentScreen(),
                    ),
                  ),
                  child: Text("Назначить встречу"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Color.fromRGBO(254, 164, 29, 1),
                  ),
                  onPressed: () {},
                  child: Text("Выбрать пациента"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: <Widget>[
          Image.asset(
            'assets/images/doctor_big_preview.png',
            width: 100,
            height: 100,
          ),
          SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Alla Ivanova',
                style: TextStyle(
                  color: Color.fromRGBO(37, 94, 214, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
