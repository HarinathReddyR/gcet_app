import 'package:flutter/widgets.dart';

class FreshArrivalsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          BookCover(title: 'Very Nice', imageUrl: 'assets/very_nice.jpg'),
          BookCover(title: 'Doll maker', imageUrl: 'assets/doll_maker.jpg'),
          BookCover(
              title: 'Stars in the sky',
              imageUrl: 'assets/stars_in_the_sky.jpg'),
        ],
      ),
    );
  }
}

class BookCover extends StatelessWidget {
  final String title;
  final String imageUrl;

  const BookCover({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Image.asset(imageUrl, width: 100, height: 150),
          SizedBox(height: 8),
          Text(title),
        ],
      ),
    );
  }
}
