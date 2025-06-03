import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class RecordButtonWithTimer extends StatefulWidget {
  final bool isPausing;
  final bool isRecording;
  final Function(bool endTime) onEndTime;
  final Function(int timer) onChangeTimer;
  const RecordButtonWithTimer({super.key, required this.isPausing, required this.isRecording, required this.onEndTime, required this.onChangeTimer});

  @override
  State<RecordButtonWithTimer> createState() => _RecordButtonWithTimerState();
}

class _RecordButtonWithTimerState extends State<RecordButtonWithTimer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _elapsedSeconds = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    );

    if (widget.isRecording && !widget.isPausing) {
      _controller.forward();
      _startTimer();
    }
  }

  void _startTimer() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (widget.isRecording && !widget.isPausing) {
        if (_elapsedSeconds < 60) {
          setState(() {
            _elapsedSeconds++;
          });
          widget.onChangeTimer(_elapsedSeconds);
        }
        if (_elapsedSeconds >= 60) {
          widget.onEndTime(true);
          _timer?.cancel();
        }
      }
    });
  }


  void _stopTimer() {
    _timer?.cancel();
  }

  @override
  void didUpdateWidget(covariant RecordButtonWithTimer oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Bắt sự kiện khi isRecording chuyển từ true -> false
    if (oldWidget.isRecording == true  && widget.isRecording == false) {
      print('🎯 isRecording vừa chuyển từ true sang false');

      // Reset timer và controller nếu cần
      _stopTimer();
      _controller.reset();
    }

    // Nếu chỉ tạm dừng (isPausing true)
    if (oldWidget.isPausing == false && widget.isPausing == true) {
      print('⏸ isPausing: tạm dừng');
      _stopTimer();
      _controller.stop();
    }

    // Nếu tiếp tục từ pause
    if (oldWidget.isPausing == true && widget.isPausing == false) {
      print('▶️ isPausing: tiếp tục');
      _startTimer();
      _controller.forward(from: _controller.value);
    }
  }


  @override
  void dispose() {
    _controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: screenHeight * 0.1,
      height: screenHeight * 0.1,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return RecordButton(progress: _controller.value, isPausing: widget.isPausing,);
        },
      ),
    );
  }
}

class RecordButton extends StatelessWidget {
  final double progress; // 0.0 - 1.0
  final bool isPausing;
  const RecordButton({super.key, required this.progress, required this.isPausing});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).width;
    return CustomPaint(
      painter: _CircleProgressPainter(progress),
      child: Center(
        child: Container(
          width: isPausing ? screenHeight * 0.1:  screenHeight * 0.15,
          height: isPausing ? screenHeight * 0.1:  screenHeight * 0.15,
          decoration: const BoxDecoration(
            color: Color(0xFFEB5545),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: const Color(0xFFD14A3B),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CircleProgressPainter extends CustomPainter {
  final double progress;

  _CircleProgressPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    double outerRadius = size.width / 2 - 13;
    Offset center = Offset(size.width / 2, size.height / 2);

    // Draw background circle
    Paint bgPaint = Paint()
      ..color = const Color(0x1A7B61FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawCircle(center, outerRadius, bgPaint);

    // Draw progress arc
    Paint progressPaint = Paint()
      ..color = const Color(0xFF8B7BFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * progress;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: outerRadius),
      startAngle,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}