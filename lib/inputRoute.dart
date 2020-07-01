import 'package:flutter/material.dart';

import 'Database.dart';
import 'Students.dart';

final nameController = TextEditingController();
final ageController = TextEditingController();
String name;
int age;
List<String> students_name = new List();
List<int> students_age = new List();
List<Student> studentData = new List();

class inputRoute extends StatefulWidget {

  @override
  createState() => inputRouteState();
}

class inputRouteState extends State<inputRoute> {

  bool nameError = false;
  bool ageError = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Try app',
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).accentColor,
            automaticallyImplyLeading: true,
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Input Route'),
          ),

          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _buildName('Name', nameController, nameError, 'Enter Name'),
                _buildName('Age', ageController, ageError, 'Invalid Age Entered'),
                RaisedButton(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text('Save'),
                      Padding(
                        padding: const EdgeInsets.only(left:6.0),
                        child: Icon(Icons.save),
                      ),
                    ],
                  ),
                  onPressed: saveButton,
                ),
              ],
            ),
          )),
    );
  }

  void saveButton() async{

    if(nameController.text == '' && ageController.text == ''){
      setState(() {
        nameError = true;
        ageError = true;
      });
      return;
    }

    try {
      age = int.parse(ageController.text);
      setState(() {
        ageError = false;
      });
    } on Exception catch (e) {
      print('Error: $e');
      setState(() {
        ageError = true;
      });
    }

    if(nameController.text == ''){
      setState(() {
        nameError = true;
      });
      return;
    }

    try {
      name = nameController.text;
      setState(() {
        nameError = false;
      });
    } on Exception catch (e) {
      print('Error: $e');
      setState(() {
        nameError = true;
      });
      return;
    }

    if(ageError==true)
      return;

    Student temp = Student(name: name,age: age);
    await DBProvider.db.newStudent(temp);
    nameController.text = '';
    ageController.text = '';
  }
}

class _buildName extends StatelessWidget{

  String _inputtype;
  TextEditingController _controller;
  bool _error;
  String _errormsg;

  _buildName(this._inputtype, this._controller, this._error, this._errormsg);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width/2,
        padding: EdgeInsets.only(bottom: 26),
        child: Form(
          child: TextFormField(
            decoration: InputDecoration(
              errorText: _error ? _errormsg : null,
              labelText: _inputtype,
              fillColor: Colors.white,
            ),
            style: TextStyle(
              fontSize: 18,
            ),
            keyboardType: (_inputtype == 'Age')
                ? TextInputType.number
                : TextInputType.text,
            controller: _controller,
          ),
        )
    );
  }
}
