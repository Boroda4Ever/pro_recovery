import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../../models/RecommendDoctor.dart';

class RecommendDoctorCard extends StatelessWidget {
  const RecommendDoctorCard({
    Key? key,
    required this.doctor,
  }) : super(key: key);

  final RecommendedDoctor doctor;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(defaultPadding)),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Алла Иванова",
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: defaultPadding / 2),
                      width: 2,
                      height: 48,
                      decoration: BoxDecoration(
                        color: Color(0xFF83D047),
                        borderRadius: const BorderRadius.all(
                            Radius.circular(defaultPadding)),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Булимия",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        Text(
                          "Пациент приглашен 24.04.22" +
                              "\n" +
                              "Последняя встреча: 25.04.22",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Image.asset(doctor.image),
          ),
        ],
      ),
    );
  }
}
