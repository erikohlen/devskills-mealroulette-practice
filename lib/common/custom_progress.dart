import 'package:flutter/material.dart';

class CustomCircularProgress extends StatelessWidget {
  final double? value;

  const CustomCircularProgress({Key? key, this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: CircularProgressIndicator(
        color: Colors.black12,
        value: value,
      ),
    );
  }
}
