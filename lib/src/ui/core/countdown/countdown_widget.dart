import 'package:countdown_app/src/ui/core/countdown/countdown_controller.dart';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final TextStyle textStyle;
  final CountdownController controller;

  const CountdownWidget({
    super.key,
    required this.textStyle,
    required this.controller,
  });

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  @override
  void initState() {
    widget.controller.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.controller,
      builder: (_, countDownVNValue, _) {
        final minutes = countDownVNValue.inMinutes.toString().padLeft(2, '0');
        final seconds = countDownVNValue.inSeconds
            .remainder(60)
            .toString()
            .padLeft(2, '0');
        return Text('$minutes:$seconds', style: widget.textStyle);
      },
    );
  }
}
