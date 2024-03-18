import 'dart:async';

import 'package:flutter/material.dart';

class IdleDetector extends StatefulWidget {
  final int idleTime;
  final Widget child;
  final void Function(int remaining)? onTick;

  const IdleDetector({
    super.key,
    required this.idleTime,
    required this.child,
    this.onTick,
  });

  @override
  IdleDetectorState createState() => IdleDetectorState();
}

class IdleDetectorState extends State<IdleDetector> {
  Timer? _timer;
  late int _remainingSeconds;

  @override
  void initState() {
    super.initState();
    _resetTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _resetTimer() {
    _timer?.cancel();
    _remainingSeconds = widget.idleTime * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _remainingSeconds--;
      });
      if (_remainingSeconds <= 0) {
        _timer!.cancel();
      }
      if (widget.onTick != null) {
        widget.onTick!(_remainingSeconds); // Pass remaining seconds to callback
      }
    });
  }

  void handleUserInteraction() {
    _resetTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        handleUserInteraction();
      },
      onPanDown: (details) {
        handleUserInteraction();
      },
      onHorizontalDragEnd: (details) {
        handleUserInteraction();
      },
      onVerticalDragEnd: (details) {
        handleUserInteraction();
      },
      child: widget.child,
    );
  }
}
