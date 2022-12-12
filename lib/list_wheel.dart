import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ListWheel extends StatefulWidget {
  const ListWheel({super.key});

  @override
  State<ListWheel> createState() => _ListWheelState();
}

class _ListWheelState extends State<ListWheel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListWheelScrollView(
          itemExtent: 82,
          children: List.generate(
              20,
              (index) => ListTile(
                    tileColor: Colors.red,
                    title: Text(
                      '$index',
                      textAlign: TextAlign.center,
                    ),
                  ))),
    );
  }
}
