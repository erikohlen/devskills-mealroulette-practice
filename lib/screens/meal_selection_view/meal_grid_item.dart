import 'package:flutter/material.dart';
import 'package:mobile_boilerplate_flutter/models/meal.dart';

import '../meal_detail_view/meal_detail_view.dart';

class MealGridItem extends StatelessWidget {
  final Meal meal;
  const MealGridItem(this.meal, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => MealDetail(meal)));
      },
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 1.6,
            child: Image.network(
              meal.picture,
              fit: BoxFit.cover,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                  color: Colors.black12,
                  child: Center(
                    child: CircularProgressIndicator(
                      value: loadingProgress.expectedTotalBytes != null
                          ? loadingProgress.cumulativeBytesLoaded /
                              loadingProgress.expectedTotalBytes!
                          : null,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(
              meal.title,
              softWrap: true,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
