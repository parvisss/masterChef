import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class BottomButton extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback onPressed;

  const BottomButton({
    super.key,
    required this.width,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(width, 50),
        backgroundColor: const Color(0xff3FB4B1),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
