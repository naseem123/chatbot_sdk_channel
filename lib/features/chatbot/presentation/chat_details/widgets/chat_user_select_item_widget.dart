import 'package:chatbot/core/extensions/string_extensions.dart';
import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class ChatUserSelectItemWidget extends StatefulWidget {
  const ChatUserSelectItemWidget({
    super.key,
    required this.buttons,
    required this.onUserInputTriggered,
    required this.color,
    required this.colorSecondary,
  });

  final Function(Block) onUserInputTriggered;
  final List<Block> buttons;
  final Color color;
  final Color colorSecondary;

  @override
  State<ChatUserSelectItemWidget> createState() =>
      _ChatUserSelectItemWidgetState();
}

class _ChatUserSelectItemWidgetState extends State<ChatUserSelectItemWidget> {
  String? _value;

  @override
  void initState() {
    super.initState();
    //_value = widget.buttons.map((element)=> element.label).toList().first;
  }

  @override
  Widget build(BuildContext context) {
    final viewInsets = MediaQuery.of(context).padding;
    return Container(
      height: 82,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(
          left: 15, right: 15, bottom: viewInsets.bottom, top: 8),
      color: widget.color,
      child: SizedBox(
          width: MediaQuery.of(context).size.width - 30,
          child: Row(
            children: [
              Expanded(
                  child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: CupertinoButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        title: const Text('Select an Option'),
                        actions: widget.buttons
                            .map(
                              (e) => CupertinoActionSheetAction(
                                onPressed: () {
                                  setState(() {
                                    _value = e.label;
                                  });

                                  context.pop();
                                },
                                child: selectedItem(e.label, context),
                              ),
                            )
                            .toList(),
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      Expanded(
                        child: !_value.isNullOrEmpty
                            ? selectedItem(_value!, context)
                            : Text(
                                'Select an option',
                                style: GoogleFonts.arimo(
                                  color: context.secondaryColor.gray52,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                      ),
                      const ImageIcons(path: 'assets/icons/drop_down_icon.svg')
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Button.iconButton(
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _value.isNullOrEmpty
                      ? const Color(0xFFE4E4E7)
                      : widget.colorSecondary,
                ),
                child: const Icon(
                  Icons.send,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              onPressed: () {
                if (_value == null) {
                  return;
                }
                widget.onUserInputTriggered(widget.buttons
                    .firstWhere((element) => element.label == _value));
              },
            )
          ],
        ),
      ),
    );
  }

  Text selectedItem(String label, BuildContext context) {
    return Text(
      label,
      textAlign: TextAlign.left,
      style: GoogleFonts.arimo(
        color: context.secondaryColor.mostlyBlack,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
