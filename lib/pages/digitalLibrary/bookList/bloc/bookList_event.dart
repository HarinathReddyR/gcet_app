abstract class BookListEvent {}

class FetchBooksByCategory extends BookListEvent {
  final String category;

  FetchBooksByCategory(this.category);
  List<Object> get props => [category];
}
