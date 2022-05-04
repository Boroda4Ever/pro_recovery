import 'package:pro_recovery/constants.dart';
import 'package:pro_recovery/screens/auth/sign_in_screen.dart';
import 'package:pro_recovery/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'account_selection.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          SvgPicture.asset(
            "assets/icons/splash_bg.svg",
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Spacer(),
                  SvgPicture.asset(
                    "assets/icons/logo_pro_recovery.svg",
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SelectionScreen(),
                        )),
                    style: TextButton.styleFrom(
                      minimumSize: Size(double.infinity, 0),
                      backgroundColor: Color(0xFF6CD8D1),
                    ),
                    child: Text(
                      "Создать аккаунт",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: ElevatedButton(
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
                        backgroundColor: Colors.transparent,
                      ),
                      child: Text(
                        "Войти в аккаунт",
                        style: TextStyle(fontSize: 16),
                      ),
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
}
