import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_boilerplate_flutter/models/meal.dart';
import 'package:mobile_boilerplate_flutter/widgets/custom_divider.dart';
import 'package:mobile_boilerplate_flutter/screens/meal_selection_view/meal_grid_item.dart';
import 'package:http/http.dart' as http;

class MealSelectionView extends StatefulWidget {
  const MealSelectionView({Key? key}) : super(key: key);

  @override
  _MealSelectionViewState createState() => _MealSelectionViewState();
}

class _MealSelectionViewState extends State<MealSelectionView> {
  late Future<List<Meal>> _meals;
  int _currentMealIndex = 0;

  Future<List<Meal>> fetchMeals(int fromIndex) async {
    final response = await http.get(Uri.parse(
        'https://playground.devskills.co/api/rest/meal-roulette-app/meals/limit/4/offset/$_currentMealIndex'));

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      print(jsonDecode(response.body)["meal_roulette_app_meals_aggregate"]
          ["nodes"]);
      print('Status 200');
      List<dynamic> _data =
          jsonDecode(response.body)["meal_roulette_app_meals_aggregate"]
              ["nodes"];
      print(_data);
      return _data.map((e) => Meal.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  void initState() {
    super.initState();
    _meals = fetchMeals(_currentMealIndex);
  }

  void _handleRefresh() {
    setState(() {
      _currentMealIndex += 4;
      _meals = fetchMeals(_currentMealIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 8,
            child: FutureBuilder<List<Meal>>(
                future: _meals,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return Padding(
                      padding:
                          const EdgeInsets.only(top: 32.0, left: 16, right: 16),
                      child: GridView.count(
                        childAspectRatio: 0.8,
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 0,
                        children: snapshot.data!
                            .map((meal) => MealGridItem(meal))
                            .toList(),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return Center(child: const CircularProgressIndicator());
                }),
          ),
          CustomDivider(),
          GestureDetector(
            onTap: _handleRefresh,
            child: Padding(
              padding: const EdgeInsets.only(top: 24.0, bottom: 32),
              child: Container(
                  height: 120,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white24,
                      border: Border.all(width: 1, color: Colors.black26)),
                  child: Center(
                    child: Text(
                      'Refresh',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  )),
            ),
          )
        ],
      )),
    );
  }
}
