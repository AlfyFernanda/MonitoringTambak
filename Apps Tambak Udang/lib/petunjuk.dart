import 'package:flutter/material.dart';

class Petunjuk extends StatefulWidget {
  @override
  _PetunjukState createState() => _PetunjukState();
}

class _PetunjukState extends State<Petunjuk> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        padding: new EdgeInsets.all(10.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Card(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(20.0),
                  ),
                  new Text(
                    "Ketinggian Air Tidak Sesuai",
                    style: new TextStyle(fontSize: 25.0),
                  ),
                  new Text(
                    "Silahkan Cek Tambak Anda",
                    style: new TextStyle(fontSize: 25.0),
                  ),
                  new Padding(
                    padding: new EdgeInsets.all(20.0),
                  ),
                  new Image.asset("gambar/notall.jpg", width: 400.0)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
