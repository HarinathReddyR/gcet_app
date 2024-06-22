import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CircularProgressWidget extends StatefulWidget {
  final double cgpa;

  CircularProgressWidget({required this.cgpa});

  @override
  _CircularProgressWidgetState createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    final percentage = widget.cgpa / 10;

    _animation =
        Tween<double>(begin: 0, end: percentage).animate(_animationController)
          ..addListener(() {
            setState(() {});
          });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Color getColor() {
    if (_animation.value >= 0.8) {
      return Colors.green;
    } else if (_animation.value >= 0.5) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  String getText() {
    if (_animation.value >= 0.8) {
      return "outstanding";
    } else if (_animation.value >= 0.5) {
      return "can do better";
    } else {
      return "improve";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "CGPA",
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 10.0),
        CircularPercentIndicator(
          radius: 65,
          lineWidth: 10,
          percent: _animation.value,
          center: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(_animation.value * 10).toStringAsFixed(2)}",
                style: TextStyle(fontSize: 19, color: Colors.black),
              ),
            ],
          ),
          progressColor: getColor(),
          backgroundColor: Colors.grey[800]!,
          circularStrokeCap: CircularStrokeCap.round,
        ),
        SizedBox(height: 10.0),
        Text(
          getText(),
          style: TextStyle(fontSize: 18.0, color: getColor()),
        ),
      ],
    );
  }
}
