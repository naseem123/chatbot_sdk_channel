import 'package:chatbot/features/chatbot/model/survey_input.dart';
import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SurveyWidget extends StatelessWidget {
  const SurveyWidget({
    super.key,
    required this.surveyModel,
    required this.onSurveyStartClicked,
    required this.primaryColor,
  });

  final SurveyMessage surveyModel;

  final void Function(String) onSurveyStartClicked;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: surveyModel.children.map((e) {
          if (e is SurveyInputText) {
            return SizedBox(
              width: double.infinity,
              child: Text(
                e.text,
                style: getStyle(context, e.style),
                textAlign: getTextAlign(e.align),
              ),
            );
          } else if (e is SurveyInputSeparator) {
            return Divider(
              color: context.secondaryColor.gray52,
            );
          } else if (e is SurveyInputButton) {
            return Container(
              width: double.infinity,
              alignment: Alignment.center,
              child: SizedBox(
                width: 92,
                height: 32,
                child: Button.accent(
                  primaryColor: primaryColor,
                  buttonRadius: 4,
                  onPressed: () => onSurveyStartClicked(e.surveyEncodes),
                  child: Text(
                    e.label,
                    style: GoogleFonts.inter(
                      color: context.secondaryColor.mostlyWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            );
          }
          return const SizedBox.shrink();
        }).toList(),
      ),
    );
  }

  TextAlign getTextAlign(String align) {
    if (align == 'center') {
      return TextAlign.center;
    }
    if (['start', 'left'].contains(align)) {
      return TextAlign.start;
    }
    if (['end', 'right'].contains(align)) {
      return TextAlign.end;
    }
    return TextAlign.start;
  }

  TextStyle getStyle(BuildContext context, String style) {
    TextStyle tStyle = GoogleFonts.inter(
      height: 1.3,
    );
    if (style == 'muted') {
      tStyle = tStyle.copyWith(
        color: context.secondaryColor.gray52,
        fontSize: 14,
        height: 1.3,
      );
    } else if (style == 'header') {
      tStyle = tStyle.copyWith(
        color: context.secondaryColor.mostlyBlack,
        fontSize: 22,
        fontWeight: FontWeight.bold,
        height: 1.3,
      );
    } else if (style == 'paragraph') {
      tStyle = tStyle.copyWith(
        color: context.secondaryColor.mostlyBlack,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        height: 1.3,
      );
    }
    return tStyle;
  }
}
