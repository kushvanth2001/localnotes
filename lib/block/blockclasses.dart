/*import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';

import 'package:qurinom_notes_app/block/notecubit.dart';

class Notecubit extends Cubit<NoteCubitState> {
  late Box<Map<dynamic, dynamic>> _hiveBox;

  Notecubit() : super(NoteInitial(notes: [], title: [], dateofcreation: [])) {
    _initHive();
    _fetchNotesFromHive();
  }

  Future<void> _initHive() async {
    _hiveBox = await Hive.openBox<Map<dynamic, dynamic>>('notesBox');
  }

  Future<void> _fetchNotesFromHive() async {
    final List<String> notes = [];
    final List<String> titles = [];
    final List<String> dateOfCreation = [];

    for (var i = 0; i < _hiveBox.length; i++) {
      final Map<dynamic, dynamic>? noteMap = _hiveBox.get(i);

      if (noteMap != null) {
        notes.add(noteMap['note']);
        titles.add(noteMap['title'] );
        dateOfCreation.add(noteMap['dateOfCreation']);
      }
    }

    emit(NoteLoaded(notes, titles, dateOfCreation));
  }

  void addNote(String noteText, String title) {
    final String formattedDate = DateFormat.yMd().add_Hm().format(DateTime.now());
    final Map<dynamic, dynamic> noteMap = {
      'note': noteText,
      'title': title,
      'dateOfCreation': formattedDate,
    };

    _hiveBox.add(noteMap);

    _fetchNotesFromHive();
  }

  void deleteNoteAtIndex(int index) {
    _hiveBox.deleteAt(index);

    _fetchNotesFromHive();
  }

  void editNoteAtIndex(int index, String editedNote, String editedTitle) {
    final Map<dynamic, dynamic> noteMap = {
      'note': editedNote,
      'title': editedTitle,
      'dateOfCreation': state.dateofcreation[index],
    };

    _hiveBox.putAt(index, noteMap);

    _fetchNotesFromHive();
  }
}




*/