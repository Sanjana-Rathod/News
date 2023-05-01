import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'english_news.dart';
import 'hindi_news.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Smart Bath',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.blueGrey[100],
          body: HomePage(),
        ));
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  Future _speak() async {
    await flutterTts.setSpeechRate(1.0);
    await flutterTts.speak(
        "Welcome! Click on English to get news in English or hindi to get news in Hindi");
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
    return Container(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: [
        Text(
          'Have a secured bath',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
        SizedBox(height: 50),
        ElevatedButton(
          onPressed: _speak,
          child: Text('CLICK HERE TO GET STARTED'),
        ),
        SizedBox(height: 10),
        Column(children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsScreen()),
                );
              },
              child: Text('English'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              )),
          SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewsScreen2()),
                );
              },
              child: Text('Hindi'),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ))
        ])
      ]),
    ));
  }
}
