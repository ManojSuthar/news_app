import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final String fontFamily;
  final int maxLines;
  final TextOverflow overflow;
  final Color? color; // Nullable color

  const CustomTextWidget({
    super.key,
    required this.text,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.fontFamily = 'Poppins', // Default font
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.color, // Default is null
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      style: GoogleFonts.getFont(
        fontFamily,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color ??
              Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.color, // Fallback to theme color
        ),
      ),
    );
  }
}
