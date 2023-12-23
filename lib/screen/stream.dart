import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class StreamExample extends StatefulWidget {
  @override
  State<StreamExample> createState() => _StreamExampleState();
}

class _StreamExampleState extends State<StreamExample> {
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child('user');

  late StreamController<String> _linkStreamController;
  late Stream<String> _linkStream;

  @override
  void initState() {
    _linkStreamController = StreamController<String>();
    _linkStream = _linkStreamController.stream;

    // Start listening to the database stream
    _databaseReference.child('link').onValue.listen((event) {
      if (event.snapshot != null) {
        //String link = event.snapshot!.value.toString();
        String link = "http://" + event.snapshot!.value.toString();
        _linkStreamController.add(link);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _linkStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Watch Class'),
        ),
        body: Center(
          child: StreamBuilder<String>(
            stream: _linkStream,
            builder: (context, snapshot) {
              String link =
                  snapshot.data ?? ''; // Use the link or a default value
              return InkWell(
                onTap: () {
                  if (link.isNotEmpty) {
                    launch(link);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    'Visit Website',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
