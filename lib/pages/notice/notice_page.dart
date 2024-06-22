import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/pages/notice/bloc/notice_bloc.dart';
import 'package:gcet_app/pages/notice/notice_form.dart';

class NoticePage extends StatelessWidget {
  // final String rollNo;
  const NoticePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NoticeBloc>(
        create: (context) {
          return NoticeBloc()..add(LoadNotice() as NoticeEvent);
        },
        child: NoticeForm(),
      ),
    );
  }
}
