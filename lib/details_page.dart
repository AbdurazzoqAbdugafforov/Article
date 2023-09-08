import 'package:cinerama/response.dart';
import 'package:flutter/material.dart';

class DetailsPage extends StatefulWidget {
  final Article article;

  const DetailsPage({super.key, required this.article});

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Center(
            child: Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black),
              ),
              padding: EdgeInsets.all(50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${widget.article.id}',
                    style: TextStyle(color: Colors.blue,fontSize: 18),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${widget.article.title}',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700,color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text('${widget.article.body}',style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
