import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gcet_app/models/book_model.dart';
import 'package:gcet_app/pages/digitalLibrary/bookDetails.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bloc/bookList_bloc.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bloc/bookList_state.dart';
import 'package:gcet_app/theme/theme.dart';

class BookListForm extends StatefulWidget {
  final String category;
  final Function(Book) onBookRead;
  const BookListForm(
      {super.key, required this.category, required this.onBookRead});

  @override
  State<BookListForm> createState() => _BookListFormState();
}

class _BookListFormState extends State<BookListForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appbar(),
        body:
            BlocBuilder<BookListBloc, BookListState>(builder: (context, state) {
          if (state is BookListLoading) {
            return CircularProgressIndicator();
          } else if (state is BookListError) {
            return Center(child: Text(state.message));
          } else if (state is BookListLoaded) {
            heading(widget.category);
            Text("abhi");
            if (state.books.isEmpty)
              return Center(child: Text('No books available'));
            else {
              final books = state.books;
              return GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of books per row
                  crossAxisSpacing: 15.0,
                  mainAxisSpacing: 15.0,
                  childAspectRatio: 0.7, // Adjust to your design needs
                ),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BookDetailsPage(
                            book: book,
                            onBookRead: widget.onBookRead,
                            // onBookRead: (Book book) {
                            // },
                          ),
                        ),
                      );
                    },
                    child: Column(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Container(
                              height: 80,
                              child: Image.asset(
                                book.imageUrl,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          book.title,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4),
                        // Text(
                        //   '4.5 ⭐ | 10 votes',
                        //   style: TextStyle(color: Colors.grey),
                        //   maxLines: 1,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                      ],
                    ),
                  );
                },
              );
            }
          }
          return Center(child: Text("else page"));
        }));
  }

  _appbar() {
    return AppBar(
      backgroundColor: Colors.white, // Set AppBar background color to white
      leading: IconButton(
        icon: const Icon(CupertinoIcons.back, color: Colors.black),
        onPressed: () {
          Navigator.pop(context); // Navigate back to the previous page
        },
      ),
      actions: [
        Stack(
          children: [
            IconButton(
              icon: Icon(Icons.more_vert_sharp, color: Colors.black),
              onPressed: () {},
            ),
          ],
        ),
      ],
      elevation: 0, // Remove AppBar shadow
    );
  }
}
