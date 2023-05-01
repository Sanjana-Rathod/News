import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Reader',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NewsScreen2(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class NewsScreen2 extends StatefulWidget {
  @override
  _NewsScreen2State createState() => _NewsScreen2State();
}

class _NewsScreen2State extends State<NewsScreen2> {
  FlutterTts flutterTts = FlutterTts();
  List<String> newsList = [];
  bool isSpeaking = false;

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  Future<void> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://gnews.io/api/v4/top-headlines?&lang=hi&country=in&apikey=25b093c6d172120a77f0ff64f05d74a4'));

    if (response.statusCode == 200) {
      setState(() {
        final newsData = jsonDecode(response.body);
        final articles = newsData['articles'] as List<dynamic>;
        newsList =
            articles.map((article) => article['title'] as String).toList();
      });
    }
  }

  Future _speak() async {
    await flutterTts.setSpeechRate(1.0);
    final newsText = newsList.join('.\n');
    await flutterTts.setLanguage("hi-IN");
    await flutterTts.speak(newsText);

    setState(() {
      isSpeaking = true;
    });
  }

  Future _stop() async {
    await flutterTts.stop();
    setState(() {
      isSpeaking = false;
    });
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up),
            onPressed: isSpeaking ? _stop : _speak,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: newsList.length,
        itemBuilder: (context, index) {
          final news = newsList[index];
          return ListTile(
            title: Text(news),
          );
        },
      ),
    );
  }
}
