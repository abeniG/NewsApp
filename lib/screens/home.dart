import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:news_app/screens/details.dart';


import '../model/article.dart';
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String apiKey = '2a1fa21f92a1451ea5a43f17ff65f52a';
  final String apiUrl =
      'https://newsapi.org/v2/top-headlines?country=us&category=business';

  Future<List<Article>> fetchArticles() async {
    var response = await http.get(Uri.parse('$apiUrl&apiKey=$apiKey'));

    if (response.statusCode == 200) {
      List<Article> articles = [];
      var jsonData = jsonDecode(response.body);

      for (var article in jsonData['articles']) {
        articles.add(Article.fromJson(article));
      }

      return articles;
    } else {
      throw Exception('Failed to load articles');
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: _appBar(),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: Column(
            children: [
           FutureBuilder(
            future: fetchArticles(),
             builder: (context, snapshot) {
               if (snapshot.connectionState == ConnectionState.waiting) {
                 return Center(child: CircularProgressIndicator());
               } else if (snapshot.hasError) {
                 return Center(child: Text('Error: ${snapshot.error}'));
               } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                 return Center(child: Text('No data available'));
               } else {
                 List<Article>? articles = snapshot.data;
                 return ListView.builder(
                   itemCount: articles?.length,
                   shrinkWrap: true,
                   itemBuilder: (context, index) {
                     return ListTile(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                           return Details(Title: articles![index].title, img: articles![index].urlToImlg, description: articles![index].urlToImlg, content: articles![index].content );
                         }));
                       },
                       leading: Image.network('${articles![index].urlToImlg}'),
                       title: SingleChildScrollView(
                         scrollDirection: Axis.horizontal,
                         child: Row(
                           children: [
                             Text(articles![index].title),
                           ],
                         ),
                       ),
                       subtitle: SingleChildScrollView(
                         child: Row(
                           children: [
                             Text(articles![index].author),
                           ],
                         ),
                       ),
                     );
                   },
                 );
               }
             }
                ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _appBar() {
    return AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(Icons.menu),
            Icon(Icons.search)
          ],
        ),
      );
  }

}