import 'package:flutter/cupertino.dart';
import 'package:pro_recovery/calendar/calendar_screen.dart';
import 'package:pro_recovery/screens/charts/charts_screen.dart';

class Category {
  final String icon, title;

  const Category({required this.icon, required this.title});
}

const List<Category> demo_categories = [
  Category(icon: "assets/icons/calendar.svg", title: "Расписание"),
  Category(icon: "assets/icons/list.svg", title: "Редактировать расписание"),
  Category(
      icon: "assets/icons/statistics-svgrepo-com.svg", title: "Статистика"),
  Category(icon: "assets/icons/book.svg", title: "Заполненные дневники"),
];
List<Widget> routes = [
  CalendarScreen(),
  CalendarScreen(),
  Eat26Chart(),
  Eat26Chart(),
];
