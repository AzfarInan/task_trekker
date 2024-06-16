import 'package:flutter/material.dart';
import 'package:task_trekker/core/theme/app_colors.dart';
import 'dart:async';

import 'package:task_trekker/core/theme/text_theme.dart';

class StopwatchWidget extends StatefulWidget {
  final int initialMinutes;
  final ValueChanged<Duration> onStop;

  const StopwatchWidget({
    super.key,
    this.initialMinutes = 0,
    required this.onStop,
  });

  @override
  StopwatchWidgetState createState() => StopwatchWidgetState();
}

class StopwatchWidgetState extends State<StopwatchWidget> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool _isRunning = false;

  @override
  void initState() {
    super.initState();
    _elapsed = Duration(minutes: widget.initialMinutes);
  }

  void _toggleTimer() {
    if (_isRunning) {
      _stopTimer();
    } else {
      _startTimer();
    }
  }

  void _startTimer() {
    setState(() {
      _isRunning = true;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _elapsed += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    widget.onStop(_elapsed);
    setState(() {
      _isRunning = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.lightGrey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              _isRunning ? Icons.stop : Icons.play_arrow,
              color: AppColors.primary,
            ),
            onPressed: _toggleTimer,
          ),
          Text(
            _formatDuration(_elapsed),
            style: textTheme.bodyMedium!.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
