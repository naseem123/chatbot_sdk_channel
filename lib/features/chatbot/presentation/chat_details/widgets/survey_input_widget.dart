import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurveyInputWidget extends StatelessWidget {
  const SurveyInputWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.labelText,
    required this.onSurveyStartClicked,
    required this.primaryColor,
  });

  final String title;
  final String subTitle;
  final String labelText;
  final VoidCallback onSurveyStartClicked;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 7, vertical: 10),
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 3,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: GoogleFonts.arimo(
              color: context.secondaryColor.mostlyBlack,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.3,
            ),
          ),
          Text(
            subTitle,
            style: GoogleFonts.arimo(
              color: context.secondaryColor.mostlyBlack,
              fontSize: 15,
              fontWeight: FontWeight.w500,
              height: 1.3,
            ),
          ),
          SizedBox(
            width: 92,
            height: 32,
            child: Button.accent(
              primaryColor: primaryColor,
              buttonRadius: 4,
              onPressed: onSurveyStartClicked,
              child: Text(
                labelText,
                style: GoogleFonts.arimo(
                  color: context.secondaryColor.mostlyWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  height: 1.3,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
