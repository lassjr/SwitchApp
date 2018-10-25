import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raspberry PI 1',
      theme: new ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _data = "";

  void _onOff(int q) {
    var url = "http://192.168.247.195:4044/?q=$q";
    http.get(url).then((response) {
      setState(() {
        _data = response.body;
      });
    }).catchError((error) {
      setState(() {
        _data = error.message;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Raspberry PI 1"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Open Light",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 125.0),
              child: RaisedButton(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "On",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                color: Colors.grey[350],
                onPressed: () {
                  _onOff(1);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: RaisedButton(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "Off",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                color: Colors.grey[350],
                onPressed: () {
                  _onOff(0);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
