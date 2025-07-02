import 'package:flutter/material.dart';

Widget customButton({
  required String text,
  required VoidCallback onPressed,
  Color background = Colors.orange,
  Color textColor = Colors.white,
  IconData? icon,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    onPressed: onPressed,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, color: textColor),
        if (icon != null) const SizedBox(width: 8),
        Text(text, style: TextStyle(color: textColor)),
      ],
    ),
  );
}
