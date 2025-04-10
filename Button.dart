import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final double height;
  final double width;
  final String title;
  final VoidCallback onTap;
  final bool isLoading;
  final Color color;

  const Button({
    Key? key,
    required this.height,
    required this.width,
    required this.title,
    required this.onTap,
    required this.isLoading,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8.0),
        ),
        alignment: Alignment.center,
        child:
            isLoading
                ? CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
                : Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
      ),
    );
  }
}
