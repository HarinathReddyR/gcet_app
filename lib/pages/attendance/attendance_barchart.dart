import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gcet_app/models/attendance_model.dart';

class _BarChart extends StatelessWidget {
  final List<AttendanceModel> subjects;

  const _BarChart({required this.subjects});

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        barTouchData: barTouchData,
        titlesData: titlesData,
        borderData: borderData,
        barGroups: barGroups,
        gridData: gridData,
        alignment: BarChartAlignment.spaceAround,
        maxY: 150,
        minY: 0,
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: true,
        touchTooltipData: BarTouchTooltipData(
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 8,
          tooltipBorder: BorderSide(
            color: Colors.black.withOpacity(0.7),
            width: 1,
          ),
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            final attendance = subjects[groupIndex];
            final attended = attendance.attended;
            final total = attendance.total;
            final percentage = attendance.percentage;

            return BarTooltipItem(
              'Attended: $attended\nTotal: $total\nPercentage: ${percentage.toStringAsFixed(1)}%',
              const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    final style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    int index = value.toInt();
    if (index >= 0 && index < subjects.length) {
      text = subjects[index]
          .subject; // Example to use subject names for x-axis titles
    } else {
      text = ''; // Provide default or empty string if index is out of range
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8, // Adjust space to avoid overlap
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 50, // Increased reserved size for better visibility
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 35, // Increased reserved size
            interval: 50,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 8, // Adjust space to avoid overlap
                child: Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: const Border(
          bottom: BorderSide(color: Colors.black, width: 1),
          left: BorderSide(color: Colors.black, width: 1),
        ),
      );

  FlGridData get gridData => FlGridData(
        show: true,
        drawHorizontalLine: true,
        horizontalInterval: 50,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black.withOpacity(0.1),
            strokeWidth: 1,
          );
        },
      );

  List<BarChartGroupData> get barGroups =>
      List.generate(subjects.length, (index) {
        final percentage = subjects[index].percentage;
        return BarChartGroupData(
          x: index,
          barRods: [
            BarChartRodData(
              toY: percentage,
              color: Colors.primaries[index % Colors.primaries.length],
              borderRadius: BorderRadius.zero, // Sharp edges
              width: 30, // Adjust this value to increase/decrease bar width
            ),
          ],
        );
      });
}

class BarChartSample3 extends StatefulWidget {
  final List<AttendanceModel> subjects;

  const BarChartSample3({super.key, required this.subjects});

  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context)
          .size
          .width, // Ensure the chart takes full width
      height: 350, // Set a fixed height for the chart
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: AspectRatio(
          aspectRatio: 1.6,
          child: _BarChart(subjects: widget.subjects),
        ),
      ),
    );
  }
}
