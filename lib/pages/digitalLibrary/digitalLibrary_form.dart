import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcet_app/api/api_connection.dart';
import 'package:gcet_app/common/pdfViewer.dart';
import 'package:gcet_app/models/book_model.dart';
import 'package:gcet_app/pages/digitalLibrary/addbook/addbook_form.dart';
import 'package:gcet_app/pages/digitalLibrary/bookDetails.dart';
import 'package:gcet_app/pages/digitalLibrary/bookList/bookList.dart';
import 'package:gcet_app/theme/theme.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class DigitalLibraryForm extends StatefulWidget {
  const DigitalLibraryForm({super.key});

  @override
  State<DigitalLibraryForm> createState() => _DigitalLibraryFormState();
}

class _DigitalLibraryFormState extends State<DigitalLibraryForm> {
  final GlobalKey<_ContinueReadingSectionState> _continueReadingKey =
      GlobalKey<_ContinueReadingSectionState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                heading("Library"),
                const SizedBox(height: 8),
                _buildSearchBar(),
                SizedBox(height: 8),
                CategoriesSection(),
                const SizedBox(height: 8),
                buildBookSection("Fresh Arrivals"),
                subheading("Continue Reading"),
                ContinueReadingSection(
                  key: _continueReadingKey, // Set the GlobalKey
                  onRemove: _removeBookFromContinueReading,
                  onBookRead: _addBookToContinueReading,
                ),
                const SizedBox(height: 8),
                buildBookSection("Competitive"),
                buildBookSection("Mech"),
                buildBookSection("CSE"),
                buildBookSection("ECE"),
                buildBookSection("MTECH"),
                buildBookSection("MBA"),
                buildBookSection("Mech"),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 45,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search for books...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                  weight: 200,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(color: Colors.blue),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 5.0),
          Container(
            decoration: BoxDecoration(
              color: Colors.blue, // Adjust color as needed
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: IconButton(
              icon: Icon(Icons.filter_list, color: Colors.white),
              onPressed: () {
                // Handle filter action
              },
            ),
          ),
        ],
      ),
    );
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
        // Stack(
        //   children: [
        //     IconButton(
        //       icon: Icon(Icons.notifications, color: Colors.black),
        //       onPressed: () {
        //         // Handle notifications button press
        //       },
        //     ),
        //     Positioned(
        //       right: 8,
        //       top: 8,
        //       child: Container(
        //         padding: EdgeInsets.all(2),
        //         decoration: BoxDecoration(
        //           color: Colors.blue, // Adjust color as needed
        //           borderRadius: BorderRadius.circular(12),
        //         ),
        //         constraints: BoxConstraints(
        //           minWidth: 16,
        //           minHeight: 16,
        //         ),
        //         child: Text(
        //           '1',
        //           style: TextStyle(
        //             color: Colors.white,
        //             fontSize: 10,
        //           ),
        //           textAlign: TextAlign.center,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
        IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddBook()),
              );
            },
            icon: Icon(Icons.more_vert_sharp)),
      ],
      elevation: 0, // Remove AppBar shadow
    );
  }

  void _addBookToContinueReading(Book book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? continueReading =
        prefs.getStringList('continueReading') ?? [];
    String bookJson = json.encode(book.toJson());
    if (continueReading.contains(bookJson)) {
      continueReading.remove(bookJson);
    }
    continueReading.insert(0, bookJson);
    await prefs.setStringList('continueReading', continueReading);
    _continueReadingKey.currentState?.refresh();
  }

  void _removeBookFromContinueReading(Book book) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? continueReading =
        prefs.getStringList('continueReading') ?? [];
    String bookJson = json.encode(book.toJson());
    continueReading.remove(bookJson);
    await prefs.setStringList('continueReading', continueReading);
    _continueReadingKey.currentState?.refresh();
  }

  Widget buildBookSection(
    String title,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            subheading(title),
            const Spacer(),
            Text(
              "See All",
              style: TextStyle(color: Colors.grey),
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.forward,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BookListPage(
                        category: title, onBookRead: _addBookToContinueReading),
                  ),
                );
              },
            )
          ],
        ),
        FutureBuilder<List<Book>>(
          future: fetchBooks(title),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return FreshArrivalsSection(
                books: snapshot.data ?? [],
                onBookRead: _addBookToContinueReading,
              );
            }
          },
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class CategoriesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CategoryChip(label: 'Autobiography'),
          CategoryChip(label: 'Arts & Crafts'),
          CategoryChip(label: 'Thriller'),
          CategoryChip(label: 'Suspense'),
          CategoryChip(label: 'Romance'),
        ],
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String label;

  const CategoryChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 5.0),
      child: Chip(
        label: Text(label),
        backgroundColor: Colors.blue,
        labelStyle: TextStyle(color: Colors.white),
      ),
    );
  }
}

class FreshArrivalsSection extends StatelessWidget {
  final List<Book> books;
  final Function(Book) onBookRead;

  FreshArrivalsSection({required this.books, required this.onBookRead});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: books
            .map((book) => BookCover(book: book, onBookRead: onBookRead))
            .toList(),
      ),
    );
  }
}

class ContinueReadingSection extends StatefulWidget {
  final Function(Book) onRemove;
  final Function(Book) onBookRead;

  ContinueReadingSection({
    Key? key,
    required this.onRemove,
    required this.onBookRead,
  }) : super(key: key);

  @override
  _ContinueReadingSectionState createState() => _ContinueReadingSectionState();
}

class _ContinueReadingSectionState extends State<ContinueReadingSection> {
  List<Book> _books = [];

  @override
  void initState() {
    super.initState();
    _loadBooks();
  }

  Future<void> _loadBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? bookJsons = prefs.getStringList('continueReading') ?? [];
    setState(() {
      _books = bookJsons
          .map((jsonStr) => Book.fromJson(json.decode(jsonStr)))
          .toList();
    });
  }

  void refresh() {
    _loadBooks(); // Reload the books when called
  }

  @override
  Widget build(BuildContext context) {
    return _books.isEmpty
        ? Center(child: Text("No books in Continue Reading"))
        : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: _books.map((book) {
                return BookCoverWithRemove(
                  book: book,
                  onRemove: widget.onRemove,
                  onBookRead: widget.onBookRead,
                );
              }).toList(),
            ),
          );
  }

  // void _updateContinueReadingOrder(Book book) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? continueReading =
  //       prefs.getStringList('continueReading') ?? [];
  //   String bookJson = json.encode(book.toJson());

  //   if (continueReading.contains(bookJson)) {
  //     continueReading.remove(bookJson);
  //   }

  //   continueReading.insert(0, bookJson); // Move book to the top of the list
  //   await prefs.setStringList('continueReading', continueReading);

  //   setState(() {
  //     _books = continueReading
  //         .map((jsonStr) => Book.fromJson(json.decode(jsonStr)))
  //         .toList();
  //   });
  // }
}

class BookCover extends StatelessWidget {
  final Book book;
  final Function(Book) onBookRead;

  const BookCover({required this.book, required this.onBookRead});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetailsPage(
              book: book,
              onBookRead: onBookRead,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Material(
              elevation: 20,
              borderRadius: BorderRadius.circular(10),
              shadowColor: Colors.black.withOpacity(0.5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(book.imageUrl,
                    width: 100, height: 150, fit: BoxFit.cover),
              ),
            ),
            SizedBox(height: 8),
            Text(book.title),
          ],
        ),
      ),
    );
  }
}

class BookCoverWithRemove extends StatelessWidget {
  final Book book;
  final Function(Book) onRemove;
  final Function(Book) onBookRead;

  const BookCoverWithRemove({
    required this.book,
    required this.onRemove,
    required this.onBookRead,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        // Move the book to the top of the Continue Reading section

        // Navigate to PdfViewer
        onBookRead(book);
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PdfViewer(pdfPath: book.bookUrl)),
        );
      },
      child: Stack(
        children: [
          // No need to pass onBookRead here
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Image.asset(book.imageUrl, width: 100, height: 150),
                SizedBox(height: 8),
                Text(book.title),
              ],
            ),
          ),

          Positioned(
            top: 0,
            right: 0,
            child: GestureDetector(
              onTap: () {
                onRemove(book);
              },
              child: Icon(Icons.cancel, color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
