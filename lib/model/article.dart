class Article {
  final String title;
  final String description;
  final String urlToImlg;
  final String author;
  final String content;

  Article({required this.title, required this.description, required this.urlToImlg, required this.author, required this.content});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImlg: json['urlToImage'] ?? '',
      author: json['author'] ?? '',
      content : json['content'] ?? '',
    );
  }
}