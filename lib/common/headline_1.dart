import 'package:flutter/material.dart';

class Headline1 extends StatelessWidget {
  final String text;
  const Headline1(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 48.0, bottom: 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }
}
