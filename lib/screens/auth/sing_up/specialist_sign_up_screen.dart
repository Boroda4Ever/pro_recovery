import 'package:form_field_validator/form_field_validator.dart';
import 'package:pro_recovery/bloc/auth_cubit.dart';
import 'package:pro_recovery/constants.dart';
import 'package:flutter/material.dart';
import 'package:pro_recovery/screens/auth/sign_in_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro_recovery/screens/main/main_screen.dart';

import '../components/sign_up_form.dart';

class SpecialistSignUpScreen extends StatefulWidget {
  const SpecialistSignUpScreen({Key? key}) : super(key: key);

  @override
  State<SpecialistSignUpScreen> createState() => _SpecialistSignUpScreenState();
}

class _SpecialistSignUpScreenState extends State<SpecialistSignUpScreen> {
  String _email = "";
  String _username = "";
  String _password = "";
  String _phone = "";

  final _formKey = GlobalKey<FormState>();

  void _submit() {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    _formKey.currentState!.save();

    context.read<AuthCubit>().specialistSignUpWithEmail(
        email: _email, username: _username, password: _password, phone: _phone);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
          listener: (prevState, currentState) {
        if (currentState is AuthSignedUp) {
          // Navigator.of(context).pushAndRemoveUntil(
          //   MaterialPageRoute<void>(
          //       builder: (BuildContext context) => MainScreen()),
          //   ModalRoute.withName('/'),
          // );
        }
        if (currentState is AuthError) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Theme.of(context).errorColor,
              content: Text(
                currentState.message,
                style: TextStyle(color: Theme.of(context).colorScheme.onError),
              ),
              duration: const Duration(seconds: 2),
            ),
          );
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
                "???????????????? ???????????????? ??????????????????????",
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text("?????? ???????? ???????????????"),
                  TextButton(
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SignInScreen(),
                      ),
                    ),
                    child: Text("?????????? ?? ???????????????????????? ??????????????!"),
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
                      validator: RequiredValidator(errorText: requiredField),
                      onSaved: (newValue) {
                        _username = newValue!.trim();
                      },
                      decoration: InputDecoration(labelText: "?????????????? ??????*"),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
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
                        decoration:
                            InputDecoration(labelText: "?????????????? email*"),
                      ),
                    ),
                    TextFormField(
                      onSaved: (newValue) {
                        _phone = newValue!.trim();
                      },
                      decoration:
                          InputDecoration(labelText: "?????????????? ?????????? ????????????????"),
                      keyboardType: TextInputType.phone,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: defaultPadding),
                      child: TextFormField(
                        validator: passwordValidator,
                        obscureText: true,
                        onChanged: (value) => _password = value,
                        onSaved: (pass) {
                          _password = pass!.trim();
                        },
                        decoration:
                            InputDecoration(labelText: "?????????????? ????????????*"),
                      ),
                    ),
                    TextFormField(
                      validator: (val) =>
                          MatchValidator(errorText: '???????????? ???? ??????????????????')
                              .validateMatch(val!, _password),
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: "?????????????????????? ????????????*"),
                    ),
                    SizedBox(height: defaultPadding * 1.5),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _submit(),
                        child: Text("?????????????? ??????????????"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    ));
  }
}
