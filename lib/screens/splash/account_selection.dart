import 'package:pro_recovery/constants.dart';
import 'package:pro_recovery/screens/auth/sign_in_screen.dart';
import 'package:pro_recovery/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../auth/sing_up/patient_sign_up_screen.dart';
import '../auth/sing_up/specialist_sign_up_screen.dart';
import 'account_selection.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({Key? key}) : super(key: key);

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/bg.svg",
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  Text(
                    'Выберите, в роли кого вы будете использовать приложение',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.fromLTRB(0, defaultPadding * 3, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width -
                              5 * defaultPadding,
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      SpecialistSignUpScreen(),
                                )),
                            style: TextButton.styleFrom(
                              minimumSize: Size(double.infinity, 0),
                              backgroundColor: Color.fromRGBO(38, 99, 227, 1),
                            ),
                            child: Text(
                              "Специалист",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () => _createInfoWindow('specialist'),
                          icon: Icon(
                            Icons.info,
                            size: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width -
                                5 * defaultPadding,
                            child: ElevatedButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PatientSignUpScreen(),
                                ),
                              ),
                              style: TextButton.styleFrom(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    color: Color(0xFF6CD8D1),
                                  ),
                                ),
                                minimumSize: Size(double.infinity, 0),
                                backgroundColor:
                                    Color.fromRGBO(254, 164, 29, 1),
                              ),
                              child: Text(
                                "Пациент",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _createInfoWindow('patient'),
                            icon: Icon(
                              Icons.info,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    ),
                    style: TextButton.styleFrom(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                          color: Color(0xFF6CD8D1),
                        ),
                      ),
                      minimumSize: Size(double.infinity, 0),
                      backgroundColor: Color.fromRGBO(108, 216, 209, 1),
                    ),
                    child: Text(
                      "Войти в аккаунт",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _createInfoWindow(String variable) {
    setState(() {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: SizedBox(
            height: 200,
            child: variable == 'specialist'
                ? const Text(
                    'Аккаунт специалиста позволяет добавлять себе пациентов, лечением которых он занимается, для доступа к возможностям приложения по упрощению своей работы.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  )
                : const Text(
                    'Аккаунт пациента позволяет привязаться к какому либо специалисту для прохождения его курса лечения.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
          ),
        ),
      );
    });
  }
}
