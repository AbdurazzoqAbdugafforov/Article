import 'dart:convert';
import 'package:cinerama/response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'details_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Article> _article = [];
  bool _isLoading = false;
  late RefreshController _controller;

  @override
  void initState() {
    super.initState();
    _initialFetchArticle();
    _controller = RefreshController();
  }

  Future<void> _initialFetchArticle() async {
    setState(() {
      _isLoading = true;
    });
    final Uri url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    final response = await http.get(url);
    final List<dynamic> jsonList = json.decode(response.body);
    setState(() {
      _article = jsonList.map((json) => Article.fromJson(json)).toList();
      _isLoading = false;
    });
  }

  Future<void> _refreshArticles() async {
    final Uri url = Uri.https('jsonplaceholder.typicode.com', '/posts');
    final response = await http.get(url);
    final List<dynamic> jsonList = json.decode(response.body);
    setState(() {
      _article = jsonList.map((json) => Article.fromJson(json)).toList();
    });
    _controller.refreshCompleted();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SmartRefresher(
              controller: _controller,
              onRefresh: _refreshArticles,
              child: ListView.builder(
                  itemCount: _article.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    DetailsPage(article: _article[index])));
                      },
                      child: Container(
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '#${_article[index].id}',
                              style: const TextStyle(color: Colors.blue),
                            ),
                            Text('${_article[index].title}'),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }
}
