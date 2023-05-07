import 'package:flutter/material.dart';

void showSnak(BuildContext context, String mes, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      duration: const Duration(seconds: 4),
      content: Text(
        mes,
        style: const TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    ),
  );
}
