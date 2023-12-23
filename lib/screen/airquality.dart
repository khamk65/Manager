import 'package:flutter/material.dart';

class AirQualityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AirQuality'),
        centerTitle: true, // Center the title
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InfoContainer(
              text: 'PM1',
              data: 'Your PM1 Value',
            ),
            InfoContainer(
              text: 'PM2.5',
              data: 'Your PM2.5 Value',
            ),
            InfoContainer(
              text: 'PM10',
              data: 'Your PM2.5 Value',
            ),
            InfoContainer(
              text: 'Co',
              data: 'Your PM2.5 Value',
            ),
          ],
        ),
      ),
    );
  }
}

class InfoContainer extends StatelessWidget {
  final String text;
  final String data;

  InfoContainer({required this.text, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          Text(
            data,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
