import 'package:equatable/equatable.dart';
import 'package:gcet_app/models/book_model.dart';

abstract class BookListState extends Equatable {
  const BookListState();

  @override
  List<Object> get props => [];
}

class BookListInitial extends BookListState {}

class BookListLoading extends BookListState {}

class BookListLoaded extends BookListState {
  final List<Book> books;

  BookListLoaded(this.books);
}

class BookListError extends BookListState {
  final String message;

  const BookListError({required this.message, required String error});

  @override
  List<Object> get props => [message];
}
