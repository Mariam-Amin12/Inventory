import 'package:curt_task/core/utililes/app_colors.dart';
import 'package:flutter/material.dart';

class Grid extends StatefulWidget {
  const Grid({super.key, required this.items});
  final List<Widget> items;

  @override
  _GridState createState() => _GridState();
}

class _GridState extends State<Grid> {
  late List<Widget> _items;

  @override
  void initState() {
    super.initState();
    _items = widget.items;
  }

  void refreshGrid(List<Widget> newItems) {
    setState(() {
      _items = newItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: _items,
          ),
        ),
      ),
    );
  }
}