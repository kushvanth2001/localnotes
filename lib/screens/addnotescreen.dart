import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qurinom_notes_app/hivecontroller.dart';
import 'package:qurinom_notes_app/screens/homepage.dart';


class AddNoteScreen extends StatefulWidget {
  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final NoteController noteController = Get.find(); 
  final TextEditingController titleController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

@override
void initState() {
  super.initState();
  if(Get.arguments[3] ==true){
    titleController.text=Get.arguments[0];
     notesController.text=Get.arguments[1
     
     ];
  }
  
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Get.arguments[3]? Text('Edit Note'): Text('Add Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: notesController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Note',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                
           Get.arguments[3]?noteController.editNote(Get.arguments[0],Get.arguments[1],titleController.text, notesController.text):
noteController.addNote(
                  notesController.text,
                  titleController.text,
                );
              
                Get.offAll(Homepage());
              },
              child: Get.arguments[3]?Text("edit note"): Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
