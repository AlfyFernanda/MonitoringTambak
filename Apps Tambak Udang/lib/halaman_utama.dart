import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'monitoring.dart' as monitoring;
import 'petunjuk.dart' as petunjuk;

class HalamanUtama extends StatefulWidget {
  @override
  _HalamanUtamaState createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 2);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: new Text("Monitoring dan Notifikasi Tambak"),
      ),
      body: new TabBarView(
        controller: controller,
        children: <Widget>[
          new monitoring.Monitoring(),
          new petunjuk.Petunjuk(),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.lightBlueAccent,
        child: new TabBar(
          controller: controller,
          tabs: <Widget>[
            new Tab(
              icon: new Icon(Icons.desktop_windows),
              text: "Monitoring",
            ),
            new Tab(
              icon: new Icon(Icons.notifications_active_sharp),
              text: "Notifikasi",
            ),
          ],
        ),
      ),
    );
  }
}
