import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pro_recovery/bloc/auth_cubit.dart';
import 'package:pro_recovery/constants.dart';
import 'package:pro_recovery/screens/auth/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:pro_recovery/screens/doctors/doctors_screen.dart';
import 'package:pro_recovery/screens/profile/profile_screen.dart';
import 'package:pro_recovery/screens/splash/account_selection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../main/main_screen.dart';
import '../settings/settings_screen.dart';
import 'components/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _email = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();
  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    context
        .read<AuthCubit>()
        .signInWithEmail(email: _email, password: _password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child:
          BlocConsumer<AuthCubit, AuthState>(listener: (prevState, currState) {
        if (currState is AuthError) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).errorColor,
              content: Text(
                currState.message,
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
        }

        if (currState is AuthSignedIn) {
          FirebaseFirestore.instance
              .collection("users")
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .get()
              .then((value) {
            var userType = (value.data())!["type"];
            if (userType == "patient") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const ProfileScreen(),
                ),
                ModalRoute.withName('/'),
              );
            } else if (userType == "specialist") {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const MainScreen(),
                ),
                ModalRoute.withName('/'),
              );
            }
          });
        }
      }, builder: (context, state) {
        if (state is AuthLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Вход в аккаунт",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text("Еще не имеете аккаунта?"),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectionScreen(),
                      ),
                    ),
                    child: Text("Создать аккаунт!"),
                  )
                ],
              ),
              SizedBox(height: defaultPadding * 1.5),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      validator: MultiValidator(
                        [
                          RequiredValidator(errorText: requiredField),
                          EmailValidator(errorText: emailError),
                        ],
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onSaved: (newValue) {
                        _email = newValue!.trim();
                      },
                      decoration: InputDecoration(labelText: "Введите email*"),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        validator: passwordValidator,
                        obscureText: true,
                        onSaved: (newValue) {
                          _password = newValue!.trim();
                        },
                        decoration:
                            InputDecoration(labelText: "Введите пароль*"),
                      ),
                    ),
                    // TextButton(
                    //   onPressed: () {},
                    //   child: Text("Забыли пароль?"),
                    // ),
                    SizedBox(height: defaultPadding),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _submit(),
                        child: Text("Sign In"),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    ));
  }
}
