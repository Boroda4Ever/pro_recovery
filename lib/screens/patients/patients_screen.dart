import 'package:flutter/services.dart';
import 'package:pro_recovery/components/custom_app_bar.dart';
import 'package:pro_recovery/constants.dart';
import 'package:pro_recovery/models/AvailableDoctor.dart';
import 'package:pro_recovery/screens/details/doctor_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:pro_recovery/screens/doctors/components/docotor_card.dart';

class PatientsScreen extends StatefulWidget {
  const PatientsScreen({Key? key}) : super(key: key);

  @override
  State<PatientsScreen> createState() => _PatientsScreenState();
}

class _PatientsScreenState extends State<PatientsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(254, 164, 29, 1),
        onPressed: () => _createInfoWindow(),
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(108, 216, 209, 1),
        title: Text(
          "Мои пациенты",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //CustomAppBar(text: "Available", title: "Specialist"),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: demoAvailableDoctors.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: defaultPadding,
                  mainAxisSpacing: defaultPadding,
                ),
                itemBuilder: (context, index) => DoctorCard(
                  doctor: demoAvailableDoctors[index],
                  press: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DoctorDetailsScreen(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _createInfoWindow() {
    setState(() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: SizedBox(
              height: 270,
              child: Column(
                children: [
                  Text(
                    'На данный момент для добавления пациента необходимо, чтобы он при регистрации указывал ваш уникальный ID\n\n Ваш уникальный ID:',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  TextButton(
                    onPressed: () =>
                        Clipboard.setData(ClipboardData(text: '215426134'))
                            .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("ID успешно скопирован")));
                    }),
                    child: Text(
                      '215426134',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                    'При нажатии он скопируется в буфер обмена',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
        ),
      );
    });
  }
}
