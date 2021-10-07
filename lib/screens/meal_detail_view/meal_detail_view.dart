import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_boilerplate_flutter/common/bodytext_1.dart';
import 'package:mobile_boilerplate_flutter/common/custom_progress.dart';
import 'package:mobile_boilerplate_flutter/common/headline_1.dart';
import 'package:mobile_boilerplate_flutter/common/headline_2.dart';
import 'package:mobile_boilerplate_flutter/screens/meal_detail_view/ingredients_list.dart';
import '../../models/meal.dart';
import 'package:http/http.dart' as http;

import '../../theme.dart';
import 'detail_image.dart';

class MealDetail extends StatefulWidget {
  final Meal meal;
  const MealDetail(this.meal, {Key? key}) : super(key: key);

  @override
  _MealDetailState createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
  late Meal _meal;
  bool _showBackButton = false;

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
      throw Exception('Failed to load meal');
    }
  }

  @override
  void initState() {
    super.initState();
    _meal = widget.meal;
    updateMealData();
    Future.delayed(
        Duration(milliseconds: 100),
        () => setState(() {
              _showBackButton = true;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: KColors.offWhite,
        extendBody: true,
        body: Stack(
          children: [
            ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(top: 32.0, left: 32, right: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DetailImage(_meal.picture),
                      Headline1(_meal.title),
                      _meal.description != null
                          ? BodyText1(_meal.description ?? '')
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: CustomCircularProgress()),
                      Headline2('Ingredients'),
                      _meal.ingredients != null
                          ? BulletList(_meal.ingredients ?? [])
                          : Align(
                              alignment: Alignment.centerLeft,
                              child: CustomCircularProgress()),
                      SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 500),
              bottom: _showBackButton ? 0 : -140,
              curve: Curves.bounceIn,
              // left: MediaQuery.of(context).size.width / 2 - 40,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: KColors.offWhiteBright,
                      border: Border.all(
                        width: 1,
                        color: Colors.black26,
                      ),
                      boxShadow: [
                        BoxShadow(color: Colors.black26, blurRadius: 8)
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.black87,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
