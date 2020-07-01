import 'package:flutter/material.dart';
import 'inputRoute.dart';
import 'listRoute.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Data',
      home: homeScreen(),
    );
  }
}

class homeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => inputRoute()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Input Data'),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Icon(Icons.input),
                  ),
                ],
              ),
            ),
            RaisedButton(
              onPressed:() {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => ListRoute()));
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('Show List'),
                  Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: Icon(Icons.list),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
