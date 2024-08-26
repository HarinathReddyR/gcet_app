import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/models/book_model.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bloc/bookList_bloc.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bloc/bookList_event.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bookList_form.dart';

class BookListPage extends StatelessWidget {
  final String category;
  final Function(Book) onBookRead;
  const BookListPage(
      {super.key, required this.category, required this.onBookRead});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<BookListBloc>(
        create: (context) {
          return BookListBloc()..add(FetchBooksByCategory(category));
        },
        child: BookListForm(category: category, onBookRead: onBookRead),
      ),
    );
  }
}
