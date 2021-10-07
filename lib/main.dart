import 'package:flutter/material.dart';
import 'screens/meal_selection_view/meal_selection_view.dart';
import 'package:mobile_boilerplate_flutter/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meal Roulette',
      theme: mealTheme,
      home: MealSelectionView(),
    );
  }
}
