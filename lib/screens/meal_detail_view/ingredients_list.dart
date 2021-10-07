import 'package:flutter/material.dart';

class BulletList extends StatelessWidget {
  final List<String> bullets;
  const BulletList(
    this.bullets, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: bullets
          .map((String bulletText) => Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Text('- $bulletText',
                      style: Theme.of(context).textTheme.bodyText1),
                ),
              ))
          .toList(),
    );
  }
}
