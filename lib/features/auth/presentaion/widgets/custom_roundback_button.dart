import 'package:flutter/material.dart';

class CustomRoundBackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final IconData icon;

  const CustomRoundBackButton({
    Key? key,
    this.onPressed,
    this.backgroundColor = Colors.white,
    this.iconColor = Colors.black,
    this.size = 44.0,
    this.icon = Icons.arrow_back,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 52.0,
      left: 20.0,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(size / 2),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: size * 0.5, // Icon size is half of the button size
          ),
        ),
      ),
    );
  }
}
