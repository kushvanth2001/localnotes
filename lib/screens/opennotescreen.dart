import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class OpenNote extends StatelessWidget {
  final String note;
  final String title;
  final String datetime;
  const OpenNote({super.key, required this.note, required this.title, required this.datetime});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: false,
        body: Container(child: Column(children: [
    Card(
      elevation: 4,
      child: ListTile(
      title: Text("Time and date"),
      subtitle:   Container(
        
        height: 40,
        
        child: Text(datetime,style: TextStyle(fontSize: 25),),),
      ),
    ),
    Card(
      elevation: 4,
      child: ListTile(
        title: Text("Title:"),
      subtitle:Text(title,style: TextStyle(fontSize: 25))),
    ),
    Card(
      elevation: 4,
      child:  Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height*0.7,
        width: MediaQuery.of(context).size.width*0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Note:"),
            SizedBox(height: 20,),
            Text(note,style: TextStyle(fontSize: 25)),
          ],
        )),
      
      
    )
    
      ],)),),
    );
  }
}