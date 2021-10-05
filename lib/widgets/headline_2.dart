import 'package:flutter/material.dart';

class Headline2 extends StatelessWidget {
  final String text;
  const Headline2(
    this.text, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0, bottom: 8),
      child: Row(
        children: [
          Text(
            text,
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }
}
