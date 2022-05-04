import 'package:firebase_auth/firebase_auth.dart';
import 'package:pro_recovery/constants.dart';
import 'package:pro_recovery/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:pro_recovery/screens/splash/splash_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        leading: IconButton(
            icon: Icon(Icons.logout, color: Colors.red),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute<void>(
                    builder: (BuildContext context) => SplashScreen()),
                ModalRoute.withName('/'),
              );
            }),
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SettingsScreen(),
              ),
            ),
            icon: Icon(
              Icons.settings,
              color: primaryColor,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            ClipRRect(
              borderRadius:
                  const BorderRadius.all(Radius.circular(defaultPadding / 2)),
              child: Image.asset(
                "assets/images/avatar.png",
                height: 120,
                width: 120,
              ),
            ),
            SizedBox(height: defaultPadding),
            Form(
              child: Column(
                children: [
                  TextFormField(
                    initialValue: "Andrey",
                    decoration: inputDecoration.copyWith(hintText: "Name"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: "test@gmail.com",
                      decoration: inputDecoration.copyWith(hintText: "Email"),
                    ),
                  ),
                  TextFormField(
                    initialValue: "88005553535",
                    decoration:
                        inputDecoration.copyWith(hintText: "Phone Number"),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: defaultPadding),
                    child: TextFormField(
                      initialValue: "Russia, Moscow",
                      decoration: inputDecoration.copyWith(hintText: "Address"),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const InputDecoration inputDecoration = InputDecoration(
  filled: true,
  fillColor: Colors.white,
  border: OutlineInputBorder(borderSide: BorderSide.none),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide.none),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide.none),
);
