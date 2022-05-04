import 'package:pro_recovery/constants.dart';
import 'package:flutter/material.dart';

class MyAppointmentScreen extends StatelessWidget {
  const MyAppointmentScreen({Key? key}) : super(key: key);

  static final DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Встречи"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(defaultPadding),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultPadding / 2)),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: buildAppointmentInfo("Дата",
                              "${_date.day}/${_date.month}/${_date.year}"),
                        ),
                        Expanded(
                          child: buildAppointmentInfo("Время", "10.30 Pm"),
                        ),
                        Expanded(
                          child:
                              buildAppointmentInfo("Пациент", "Алла Иванова"),
                        ),
                      ],
                    ),
                    Divider(height: defaultPadding * 2),
                    Row(
                      children: [
                        Expanded(
                          child: buildAppointmentInfo(
                            "Тип",
                            "Булимия",
                          ),
                        ),
                        Expanded(
                          child: buildAppointmentInfo("Место", "Онлайн"),
                        ),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {},
                            style:
                                TextButton.styleFrom(backgroundColor: redColor),
                            child: Text("Отменить"),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column buildAppointmentInfo(String title, String text) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: textColor.withOpacity(0.62),
          ),
        ),
        Text(
          text,
          maxLines: 1,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
