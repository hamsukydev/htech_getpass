import 'package:flutter/material.dart';
import 'package:htechdoor/shared/const.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ThemeButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        text.toUpperCase(),
        style: GoogleFonts.abel(),
      ),
    );
  }
}

class ThemeButtonWidth extends StatelessWidget {
  final double width;
  final String text;
  final VoidCallback onPressed;

  const ThemeButtonWidth({
    this.width = buttonWidth,
    required this.text,
    required this.onPressed,
    required context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: ThemeButton(
        onPressed: onPressed,
        text: text,
      ),
    );
  }
}

void showSnackBar({
  required BuildContext context,
  required Widget content,
  required SnackBarAction action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: content,
      action: action,
    ),
  );
}

class ThemeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const ThemeAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.abel(
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
