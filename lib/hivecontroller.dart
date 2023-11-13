import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class NoteController extends GetxController {
  late Box<List<String>> _hiveBox;

  var notes = <String>[].obs;
  var titles = <String>[].obs;
  var dateOfCreation = <String>[].obs;

  @override
  void onInit() async {
    super.onInit();
    await _initHive();
    await fetchNotesFromHive();
  }

  Future<void> _initHive() async {
    _hiveBox = await Hive.openBox<List<String>>('notesBox');
  }

Future fetchNotesFromHive() async {
  notes.clear();
  titles.clear();
  dateOfCreation.clear();

  
  final List<List<String>> allNotes = _hiveBox.values.cast<List<String>>().toList();
  print(allNotes);

  
  for (var i = 0; i < allNotes.length; i++) {
    if (allNotes[i].isNotEmpty) {
      notes.add(allNotes[i][0]);
      titles.add(allNotes[i][1]);
      dateOfCreation.add(allNotes[i][2]);
    }
  }
}



  void addNote(String noteText, String title) async{
    final String formattedDate = DateFormat.yMd().add_Hm().format(DateTime.now());
    final List<String> noteData = [noteText, title, formattedDate];

    _hiveBox.add(noteData);

    fetchNotesFromHive();
  }

  void deleteNoteAtIndex(int index)async {
   await _hiveBox.deleteAt(index);
     

    fetchNotesFromHive();
   
  }

    void editNote(String oldTitle, String oldNote, String newTitle, String newNote) {
    int index = findNoteIndex(oldTitle, oldNote);
    if (index != -1) {
      final String formattedDate = DateFormat.yMd().add_Hm().format(DateTime.now());
      final List<String> noteData = [newNote, newTitle, formattedDate];
deleteNoteAtIndex(index);
      _hiveBox.put(index, noteData);

      fetchNotesFromHive();
    }
  }

  int findNoteIndex(String title, String note) {
    for (var i = 0; i < titles.length; i++) {
      if (titles[i] == title && notes[i] == note) {
        return i;
      }
    }
    return -1;
  
  }
}
/*Future<void> printHiveBoxContents(_hiveBox) async {
  print('Printing contents of Hive box:');
  
  for (var i = 0; i < _hiveBox.length; i++) {
    final List<String>? noteData = _hiveBox.get(i);

    if (noteData != null && noteData.length == 3) {
      print('Index $i:');
      print('  Note: ${noteData[0]}');
      print('  Title: ${noteData[1]}');
      print('  Date of Creation: ${noteData[2]}');
    }
  }

  print('End of Hive box contents.');
}*/