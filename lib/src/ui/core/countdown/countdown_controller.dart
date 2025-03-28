import 'dart:async';

import 'package:flutter/material.dart';

class CountdownController extends ValueNotifier<Duration> {
  DateTime? _endTime;
  final Duration _countdownDuration;
  Timer? _timer;
  final VoidCallback? _onEnd;
  var _hasStarted = false;

  CountdownController({required Duration duration, VoidCallback? onEnd})
    : _countdownDuration = duration,
      _onEnd = onEnd,
      super(duration);

  void start() {
    if (!_hasStarted) {
      _endTime = DateTime.now().add(_countdownDuration);
      _timer?.cancel();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        final remaining = _endTime!.difference(DateTime.now());
        if (remaining.isNegative) {
          _timer?.cancel();
          _onEnd?.call();
          return;
        }
        value = remaining;
      });
      _hasStarted = true;
    }
  }

  void restart() {
    _timer?.cancel();
    _hasStarted = false;
    start();
  }

  void reset() {
    _timer?.cancel();
    value = _countdownDuration;
    _endTime = null;
  }

  @override
  void dispose() {
    _timer?.cancel();
    _hasStarted = false;
    super.dispose();
  }
}
