import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raspberry',
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

  void _onOff(String selectedVersionRaspberry, int raspberryPin) {
    var url =
        "http://192.168.247.195:8080/?ver=$selectedVersionRaspberry&pin=$raspberryPin";
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

  List<DropdownMenuItem<String>> listDrop = [];
  List<DropdownMenuItem<int>> listPin = [];
  List<int> drop = [1, 4, 5, 6, 3, 2, 0, 7];
  String selectedVersionRaspberry = null;
  int raspberryPin = null;

  void loadData() {
    listDrop = [];
    listDrop.add(new DropdownMenuItem(
      child: new Text('PI 1'),
      value: 'v1',
    ));

    listDrop.add(new DropdownMenuItem(
      child: new Text('PI 2'),
      value: 'v2',
    ));

    listDrop.add(new DropdownMenuItem(
      child: new Text('PI 3'),
      value: 'v3',
    ));
  }

  void loadPin() {
    listPin = [];
    listPin = drop
        .map((val) => new DropdownMenuItem<int>(
              child: new Text('$val'),
              value: val,
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    loadPin();
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Raspberry"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: Text(
                "Open Light",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: RaisedButton(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "On",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                color: Colors.grey[350],
                onPressed: () {
                  _onOff(selectedVersionRaspberry, raspberryPin);
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
                  _onOff(selectedVersionRaspberry, raspberryPin);
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 50.0),
              child: Text(
                "Select Raspberry Version and pin",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: DropdownButton(
                    items: listDrop,
                    value: selectedVersionRaspberry,
                    hint: new Text('Select version'),
                    onChanged: (value) {
                      selectedVersionRaspberry = value;
                      setState(() {});
                    }),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: Center(
                child: DropdownButton(
                    items: listPin,
                    value: raspberryPin,
                    hint: new Text('Select pin'),
                    onChanged: (value) {
                      raspberryPin = value;
                      setState(() {});
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
