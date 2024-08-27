import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/models/book_model.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bloc/bookList_event.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bloc/bookList_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  BookListBloc() : super(BookListInitial()) {
    on<FetchBooksByCategory>(
      (event, emit) async {
        emit(BookListLoading());
        try {
          final List<Book> books =
              await fetchBooks(event.category) as List<Book>;
          emit(BookListLoaded(books));
        } catch (e) {
          print(e);
          emit(BookListError(
              error: e.toString(), message: 'Failed to load books'));
        }
      },
    );
  }
}
