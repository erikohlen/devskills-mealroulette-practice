import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_boilerplate_flutter/widgets/bullet_list.dart';
import 'models/meal.dart';
import 'package:http/http.dart' as http;

import 'widgets/bodytext_1.dart';
import 'widgets/detail_image.dart';
import 'widgets/headline_2.dart';

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
            Padding(
              padding: const EdgeInsets.only(top: 32.0, left: 16, right: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DetailImage(_meal.picture),
                  Headline2(_meal.title),
                  _meal.description != null
                      ? BodyText1(_meal.description ?? '')
                      : CircularProgressIndicator(),
                  Headline2('Ingredients'),
                  _meal.ingredients != null
                      ? BulletList(_meal.ingredients ?? [])
                      : Center(
                          child: AspectRatio(
                              aspectRatio: 1,
                              child: Container(
                                  width: 100,
                                  height: 100,
                                  child: CircularProgressIndicator()))),
                  SizedBox(
                    height: 100,
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
