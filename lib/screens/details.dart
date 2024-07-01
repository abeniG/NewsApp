import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  String Title;
  String img;
  String description;
  String content;
  Details({super.key,required this.Title, required this.img, required this.description,required this.content });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${Title}'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Image.network('$img'),
            Text('$content')
          ],
        ),
      ),
    );
  }
}
