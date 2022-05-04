import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

const primaryColor = Color(0xFF255ED6);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);

const defaultPadding = 16.0;

const emailError = 'Введите корректный email';
const requiredField = "Это поле обязательное";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'Требуется пароль'),
    MinLengthValidator(8, errorText: 'Пароль должен быть не менее 8 символов'),
    PatternValidator(r'(?=.*?[#?!@$%^&*-])',
        errorText: 'Пароль должен содержать специальный символ')
  ],
);

const InputDecoration dropdownInputDecoration = InputDecoration(
  fillColor: Colors.white,
  filled: true,
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.white),
  ),
);
