import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Raspberry',
      theme: new ThemeData.dark(),
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
  final myController = TextEditingController();
  String ipServer;

  void _onOff(String selectedVersionRaspberry, int raspberryPin, String action,
      String ipServer) {
    var url =
        "http://$ipServer:8080/$action/?ver=$selectedVersionRaspberry&pin=$raspberryPin";
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
  List<int> drop = [
    2,
    3,
    4,
    7,
    8,
    9,
    10,
    11,
    14,
    15,
    17,
    18,
    22,
    23,
    24,
    25,
    27
  ];
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

  void onChanged(String value) {
    setState(() {
      ipServer = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    loadPin();
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: new AppBar(title: new Text("Raspberry")),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Text(
                "Select Raspberry Version pin and ip address",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: DropdownButton(
                    //style: TextStyle(color: Colors.yellowAccent[700]),
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
              margin: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: DropdownButton(
                    //style: TextStyle(color: Colors.yellowAccent[700]),
                    items: listPin,
                    value: raspberryPin,
                    hint: new Text('Select pin'),
                    onChanged: (value) {
                      raspberryPin = value;
                      setState(() {});
                    }),
              ),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 10.0, left: 115.0, right: 115.0),
              child: Center(
                child: TextField(
                  onChanged: (String value) {
                    onChanged(value);
                  },
                  decoration: InputDecoration(hintText: 'Insert IP Address'),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40.0),
              child: Text(
                "Open Light",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0),
              child: RaisedButton(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  "On",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                color: Colors.green,
                onPressed: () {
                  _onOff(
                      selectedVersionRaspberry, raspberryPin, "on", ipServer);
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
                color: Colors.red,
                onPressed: () {
                  _onOff(
                      selectedVersionRaspberry, raspberryPin, "off", ipServer);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
