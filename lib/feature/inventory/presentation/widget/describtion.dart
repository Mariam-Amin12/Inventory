import 'package:flutter/material.dart';

class Describtion extends StatelessWidget {
  const Describtion({
    super.key,required this.title, required this.value,
  });
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ), 
        Text(
         value,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
        ),
      ],
    );
  }
}
