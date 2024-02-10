import 'package:chatbot/features/chatbot/model/block_model.dart';
import 'package:flutter/material.dart';
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
    return Container(
      height: 63,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  child: DropdownButtonFormField<String>(
                    itemHeight: 50,
                    padding: EdgeInsets.zero,
                    decoration: InputDecoration(
                      hintText: _value == null ? 'Select an option' : "",
                      hintStyle: GoogleFonts.arimo(
                        color: const Color(0xFF858585),
                        fontSize: 16,
                      ),
                      isDense: true,
                    ),
                    value: _value,
                    alignment: Alignment.topLeft,
                    isDense: true,
                    items: widget.buttons
                        .map((element) => element.label)
                        .toList()
                        .map((label) => DropdownMenuItem(
                              value: label,
                              child: Text(
                                label,
                                style: GoogleFonts.arimo(
                                    color: Colors.black,
                                    fontSize: 16,
                                    height: 0.1),
                              ),
                            ))
                        .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        _value = value ?? "";
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              InkWell(
                onTap: () {
                  if (_value == null) {
                    return;
                  }
                  widget.onUserInputTriggered(widget.buttons
                      .firstWhere((element) => element.label == _value));
                },
                child: Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: widget.colorSecondary,
                  ),
                  child: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ],
          )),
    );
  }
}
