import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'sensor.dart';

class Monitoring extends StatefulWidget {
  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('monitoring');
  DatabaseReference keadaanSehat =
      FirebaseDatabase.instance.reference().child('DHT').child('Json');

  @override
  Widget build(BuildContext context) {
    return mainScaffold();
  }

  Widget mainScaffold() {
    return Scaffold(
      body: StreamBuilder(
          stream: databaseReference.onValue,
          builder: (context, snapshot) {
            if (snapshot.hasData &&
                !snapshot.hasError &&
                snapshot.data.snapshot.value != null) {
              var _sensor =
                  Sensor.fromJson(snapshot.data.snapshot.value['realtime']);
              return tampilData(_sensor);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }

  Widget tampilData(Sensor _sensor) {
    return Center(
      child: ListView(
        padding: new EdgeInsets.all(10.0),
        children: <Widget>[
          new Card(
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new Text("pH Air = ${_sensor.phAir} pH"),
                )
              ],
            ),
          ),
          new Card(
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new Text("Salinitas = ${_sensor.salinitasAir} ppt"),
                )
              ],
            ),
          ),
          new Card(
            child: new Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: new Text("Tinggi Air = ${_sensor.ketinggianAir} cm"),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
