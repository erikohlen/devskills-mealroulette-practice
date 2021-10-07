import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_boilerplate_flutter/common/custom_progress.dart';
import 'package:mobile_boilerplate_flutter/models/meal.dart';
import 'package:mobile_boilerplate_flutter/common/custom_divider.dart';
import 'package:mobile_boilerplate_flutter/screens/meal_selection_view/meal_grid_item.dart';
import 'package:http/http.dart' as http;

import '../../theme.dart';

class MealSelectionView extends StatefulWidget {
  const MealSelectionView({Key? key}) : super(key: key);

  @override
  _MealSelectionViewState createState() => _MealSelectionViewState();
}

class _MealSelectionViewState extends State<MealSelectionView> {
  late Future<List<Meal>> _meals;
  List<Meal> _cachedMeals = [];
  bool _isLoadingMeals = false;
  int _mealOffset = 0;

  Future<List<Meal>> fetchMeals(int fromIndex) async {
    final response = await http.get(Uri.parse(
        'https://playground.devskills.co/api/rest/meal-roulette-app/meals/limit/4/offset/$_mealOffset'));

    if (response.statusCode == 200) {
      List<dynamic> _data =
          jsonDecode(response.body)["meal_roulette_app_meals_aggregate"]
              ["nodes"];

      List<Meal> _fetchedMeals = _data.map((e) => Meal.fromJson(e)).toList();
      _cachedMeals += _fetchedMeals;
      bool _isTooFewMealsFetched = _fetchedMeals.length < 4;
      if (_isTooFewMealsFetched) {
        print('Is too few meals!');
        int _missingMeals = 4 - _fetchedMeals.length;
        print('Missing meals: $_missingMeals');
        List<Meal> _cachedMealsToAdd =
            _cachedMeals.getRange(0, _missingMeals).toList();
        print('_cachedMealsToAdd: ');
        print(_cachedMealsToAdd);
        print('_fetchedMeals: ');
        _fetchedMeals += _cachedMealsToAdd;
        print(_fetchedMeals);
        setState(() {
          _isLoadingMeals = false;
        });
        return _fetchedMeals;
      }
      setState(() {
        _isLoadingMeals = false;
      });
      _cachedMeals += _fetchedMeals;
      return _fetchedMeals;
    } else {
      throw Exception('Failed to load meals');
    }
  }

  @override
  void initState() {
    super.initState();
    _meals = fetchMeals(_mealOffset);
  }

  void _handleRefresh() {
    setState(() {
      _mealOffset += 4;
      _meals = fetchMeals(_mealOffset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: KColors.offWhite,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              children: [
                _isLoadingMeals
                    ? Expanded(
                        flex: 8, child: Center(child: CustomCircularProgress()))
                    : Expanded(
                        flex: 8,
                        child: FutureBuilder<List<Meal>>(
                            future: _meals,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 32.0, left: 16, right: 16),
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
                              return Center(
                                  child: const CustomCircularProgress());
                            }),
                      ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: CustomDivider(),
                ),
                GestureDetector(
                  onTap: _isLoadingMeals
                      ? null
                      : () {
                          setState(() {
                            _isLoadingMeals = true;
                          });
                          _handleRefresh();
                        },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 32),
                    child: Container(
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: KColors.offWhiteBright,
                          border: Border.all(width: 1, color: Colors.black26),
                          boxShadow: _isLoadingMeals
                              ? null
                              : [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 8)
                                ],
                        ),
                        child: Center(
                          child: Text(
                            'Refresh',
                            style: _isLoadingMeals
                                ? Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      color: Colors.black12,
                                    )
                                : Theme.of(context).textTheme.headline6,
                          ),
                        )),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
