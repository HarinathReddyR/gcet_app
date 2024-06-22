import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:gcet_app/pages/schedule/periods.dart';
import 'package:gcet_app/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/schedule/bloc/schedule_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScheduleForm extends StatefulWidget {
  final String rollNo;
  const ScheduleForm({super.key, required this.rollNo});
  @override
  State<ScheduleForm> createState() => _ScheduleFormState(rollNo);
}

class _ScheduleFormState extends State<ScheduleForm> {
  final String rollNo;
  _ScheduleFormState(this.rollNo);
  var _selectedDate = DateTime.now();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _upperBar(),
          _dateBar(),
          const SizedBox(height: 15),
          Expanded(
            child: ListView(
              children: [
                ScheduleItem(
                    fromTime: "09:00",
                    toTime: "10:00",
                    subName: "ap",
                    location: "302",
                    icon: Icons.person,
                    color: Colors.blueGrey),
                ScheduleItem(
                    fromTime: "18:00",
                    toTime: "18:00",
                    subName: "ap",
                    location: "302",
                    icon: Icons.person,
                    color: Colors.blueGrey),
                BlocBuilder<ScheduleBloc, ScheduleState>(
                  builder: (context, state) {
                    if (state is ScheduleLoaded) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListView.builder(
                              itemCount: state.periods.length,
                              itemBuilder: (context, index) {
                                final period = state.periods[index];
                                return ListTile(
                                  title: Text(
                                      "${period.fromTime}-${period.toTime}"),
                                  subtitle: Text(period.subName),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    } else if (state is ScheduleEmpty) {
                      return const Center(
                          child: Text(
                              "No periods available for the selected date"));
                    } else if (state is ScheduleError) {
                      return const Center(child: Text("an err occured"));
                    } else {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // Or any other loading indicator
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _dateBar() {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 20),
      child: DatePicker(
        DateTime(2024),
        height: 100,
        width: 80,
        initialSelectedDate: DateTime.now(),
        selectionColor: Colors.blue,
        selectedTextColor: Colors.white,
        dateTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        dayTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        monthTextStyle: GoogleFonts.lato(
            textStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        )),
        onDateChange: (date) {
          setState(() {
            _selectedDate = date;
          });
          context
              .read<ScheduleBloc>()
              .add(LoadSchedule(selectedDate: date, rollNo: rollNo));
        },
      ),
    );
  }

  _upperBar() {
    return Row(
      children: [
        Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat.yMMMMd().format(_selectedDate),
                  style: SubHeadingStyle,
                )
              ],
            )),
      ],
    );
  }

  _appBar() {
    return AppBar(
      title: const Text(
        'Daily Schedule',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: Themes.lightTheme.primaryColor,
      actions: const [
        Icon(
          Icons.person,
          size: 20,
          color: Colors.black,
        ),
        SizedBox(width: 20),
      ],
    );
  }
}
