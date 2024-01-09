import 'package:flutter/material.dart';

//brand
const Color primaryMedLabOColor = Color.fromRGBO(40, 63, 144, 1);
const Color secondaryMedLabOColor = Color.fromRGBO(199, 78, 130, 1);

//text
const Color primaryBlackTextColor = Colors.black;
const Color primaryDarkTextColor = Colors.black45;
const Color primaryLightTextColor = Colors.white60;
const Color primaryWhiteTextColor = Colors.white;

//table
const Color tableHeaderColor = Color.fromARGB(255, 238, 238, 238);

//headings
const TextStyle heading1 = TextStyle(
    fontSize: 20, color: primaryBlackTextColor, fontWeight: FontWeight.w700);
const TextStyle heading2 = TextStyle(
    fontSize: 17, color: primaryBlackTextColor, fontWeight: FontWeight.w500);
const TextStyle heading3 = TextStyle(
    fontSize: 15, color: primaryBlackTextColor, fontWeight: FontWeight.w300);

//sized boxes
//H
const SizedBox sizedBoxHeightXL = SizedBox(
  height: 30,
);
const SizedBox sizedBoxHeightL = SizedBox(
  height: 20,
);
const SizedBox sizedBoxHeightM = SizedBox(
  height: 10,
);
const SizedBox sizedBoxHeightS = SizedBox(
  height: 5,
);
//W
//H
const SizedBox sizedBoxWidthXL = SizedBox(
  width: 30,
);
const SizedBox sizedBoxWidthL = SizedBox(
  width: 20,
);
const SizedBox sizedBoxWidthM = SizedBox(
  width: 10,
);
const SizedBox sizedBoxWidthS = SizedBox(
  width: 5,
);

//button styles
const ButtonStyle btnMedLabOPrimary = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(primaryMedLabOColor),
    textStyle:
        MaterialStatePropertyAll(TextStyle(color: primaryWhiteTextColor)));
const ButtonStyle btnMedLabOSecondary = ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(secondaryMedLabOColor),
    textStyle:
        MaterialStatePropertyAll(TextStyle(color: primaryWhiteTextColor)));
