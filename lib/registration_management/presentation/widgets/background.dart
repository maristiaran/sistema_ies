import 'package:flutter/material.dart';

Stack background(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;
  final screenHeight = MediaQuery.of(context).size.height;
  return Stack(
    children: [
      Container(
        width: double.infinity,
        color: Colors.white.withOpacity(0.3),
      ),
      Container(
        width: screenWidth * 440,
        height: screenHeight * 589,
        margin: EdgeInsets.fromLTRB(0, screenHeight * 0.370, 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFF6C91C7).withOpacity(0.3),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(screenWidth * 0.5),
          ),
        ),
      ),
      Container(
        width: screenWidth * 440,
        height: screenHeight * 514,
        margin: EdgeInsets.fromLTRB(0, screenHeight * 0.445, 0, 0),
        decoration: BoxDecoration(
          color: const Color(0xFF9EBCE9).withOpacity(0.3),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(screenWidth * 0.5),
          ),
        ),
      ),
    ],
  );
}
