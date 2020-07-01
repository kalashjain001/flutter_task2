import 'package:flutter/material.dart';

import 'Students.dart';
import 'Database.dart';

class ListRoute extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => ListRouteState();
}

class ListRouteState extends State<ListRoute> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'List',
      home: Scaffold(
          appBar: AppBar(automaticallyImplyLeading: true,
            leading: BackButton(
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('List'),
          ),
          body: FutureBuilder<List<Student>>(
            future: DBProvider.db.getAllStudents(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Student>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Student item = snapshot.data[index];
                    return Container(
                        child: Card(
                            shadowColor: Colors.blue[900],
                            color: Colors.greenAccent[400],
                            child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      width: MediaQuery.of(context).size.width/2.5,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'NAME: ' + item.name,
                                          style: TextStyle(
                                              fontSize: 18
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width/3,
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          'AGE: '+ item.age.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.delete),
                                        onPressed:(){
                                          setState(() {
                                            DBProvider.db.deleteStudent(item.id);
                                          });
                                        }
                                      ),
                                    )
                                  ],
                                )
                            )
                        )
                    );
                  },
                );
              }
              else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )
      ),
    );
  }
}
