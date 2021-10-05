import 'dart:convert';

import 'package:flutter/material.dart';
import 'models/meal.dart';
import 'package:http/http.dart' as http;

class MealDetail extends StatefulWidget {
  final Meal meal;
  const MealDetail(this.meal, {Key? key}) : super(key: key);

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  late Meal _meal;

  void updateMealData() async {
    final response = await http.get(Uri.parse(
        'https://playground.devskills.co/api/rest/meal-roulette-app/meals/${widget.meal.id}'));

    if (response.statusCode == 200) {
      Map<String, dynamic> _data =
          jsonDecode(response.body)["meal_roulette_app_meals_by_pk"];
      String _ingredientsStr = _data['ingredients'];
      setState(() {
        _meal.description = _data['description'];
        _meal.ingredients = _ingredientsStr.split(',');
      });
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  void initState() {
    super.initState();
    _meal = widget.meal;
    updateMealData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        body: ListView(
          children: [
            Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.7,
                  child: Image.network(_meal.picture),
                ),
              ],
            ),
            Text(
              _meal.title,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
