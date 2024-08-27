class Book {
  final String id;
  final String title;
  final String author;
  final String imageUrl;
  final String bookUrl;
  final String about;
  final String size;
  final String edition;
  bool inList;

  Book(
      {required this.id,
      required this.title,
      required this.author,
      required this.imageUrl,
      required this.bookUrl,
      required this.about,
      required this.size,
      required this.edition,
      required this.inList});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: '123',
      title: json['title'],
      author: json['author'],
      imageUrl: json['imageUrl'],
      bookUrl: 'lib/assets/cns.pdf',
      about:
          'about consists of what book contains about consists of what book containsabout consists of what book contains',
      edition: '1.2',
      size: '25Mb',
      inList: true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'imageUrl': imageUrl,
      'bookUrl': bookUrl,
      'about': about,
      'edition': edition,
      'size': size,
      'inList': inList
    };
  }
}
