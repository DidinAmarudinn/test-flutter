import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

LinearGradient gradientBlue = const LinearGradient(
    colors: [Color(0xFF21D4FD), Color(0xFF2152FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);

LinearGradient gradientBlack = const LinearGradient(
    colors: [Color(0xFF3A416F), Color(0xFF141727)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
LinearGradient gradientPink = const LinearGradient(
    colors: [Color(0xFFFF0080), Color(0xFF7928CA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);
Color bgTextfieldAuth = const Color(0xFFF0F2FA);
Color bgTextfieldForm = const Color(0xFFF2F2F2);
Color? bgdisableTextfieldForm =  Colors.grey[200];
Color blueColor = const Color(0xFF0A65FF);
TextStyle primaryTextStyle = GoogleFonts.openSans(color: Colors.black);
TextStyle noColorTextStyle = GoogleFonts.openSans();
TextStyle greenTextStyle = GoogleFonts.openSans(color:const Color(0xFF82D616));
TextStyle whiteTextStyle = GoogleFonts.openSans(color: Colors.white);
TextStyle secondaryTextStyle =
    GoogleFonts.poppins(color: const Color(0xFF8392AB));

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;

double defaultMargin = 24;