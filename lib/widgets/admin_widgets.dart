import 'package:flutter/material.dart';

class AdminMenu extends StatelessWidget {
  const AdminMenu({
    required this.function,
    required this.text,
    required this.colors,
  });

  final Function function;
  final String text;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          function();
        },
        child: Container(
          margin: const EdgeInsets.all(20),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              stops: [0.1, 0.8],
              colors: colors,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}