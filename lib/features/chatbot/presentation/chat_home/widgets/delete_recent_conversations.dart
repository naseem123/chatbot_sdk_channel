import 'package:components/components.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

void showDeleteConversationConfirmationPopup(
    BuildContext context, VoidCallback onDeletePressed) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      child: SizedBox(
        width: double.infinity,
        height: 320,
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: ImageIcons(path: 'assets/icons/warning_icon.svg'),
            ),
            Text(
              'Clear Conversations',
              style: context.textTheme.captionBold.copyWith(
                color: context.colorScheme.primary,
                fontSize: 19,
              ),
            ),
            const Gap(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'This will clear your conversations, are you sure you want to proceed?',
                style: context.textTheme.captionRegular.copyWith(
                  color: context.secondaryColor.gray52,
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              height: 42,
              child: Button.destructive(
                onPressed: () {
                  context.pop();
                  onDeletePressed.call();
                },
                child: Text(
                  'Clear Conversations',
                  style: context.textTheme.captionBold.copyWith(
                    color: context.secondaryColor.lightWhite,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Gap(12),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 24),
              height: 42,
              child: Button.secondaryWhite(
                onPressed: context.pop,
                child: Text(
                  'Cancel',
                  style: context.textTheme.captionBold.copyWith(
                    color: context.secondaryColor.mostlyBlack,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const Gap(12),
          ],
        ),
      ),
    ),
  );
}
