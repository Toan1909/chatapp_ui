import 'package:flutter/material.dart';

class AppStyles {
  static const TextStyle title = TextStyle(
    color: Color(0xFF3D4A7A),
    fontSize: 18,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w800,
  );
  static const TextStyle subTitle = TextStyle(
    color: Color(0xFF797C7B),
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w300,
    letterSpacing: 0.10,
  );
  static const TextStyle labelText =  TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,
      overflow: TextOverflow.ellipsis
  );
  static const TextStyle subLabelText =  TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis
  );
  static const TextStyle labelText2 =  TextStyle(
    color: Color(0xFF000D07),
    fontSize: 20,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,

  );
  static const TextStyle labelText3 =  TextStyle(
      color: Color(0xFF000D07),
      fontSize: 18,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w600,
      overflow: TextOverflow.ellipsis
  );
  static const TextStyle subLabelText2 =  TextStyle(
      color: Color(0x7F797C7B),
      fontSize: 12,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w400,
      overflow: TextOverflow.ellipsis
  );
  static const TextStyle label1 = TextStyle(
    color: Color(0xFF3D4A7A),
    fontSize: 14,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w600,
    letterSpacing: 0.10,
  );
  static const TextStyle input1 = TextStyle(
    color: Color(0xFF000D07),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,
  );
  static const TextStyle selectedText =TextStyle(
    color: Color(0xFF3D4A7A),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w500,

  );
  static const TextStyle unSelectedText =TextStyle(
    color: Color(0x63797C7B),
    fontSize: 16,
    fontFamily: 'Poppins',
    fontWeight: FontWeight.w400,

  );
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    shadowColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    textStyle: const TextStyle(
      color: Colors.white,
      fontSize: 16,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
      height: 0.06,
    ),
  );
}