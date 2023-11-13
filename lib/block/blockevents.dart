import 'package:equatable/equatable.dart';
abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

class LoadNotes extends NoteEvent {}

class AddNote extends NoteEvent {
  final List<String> notes; final List<String> title; final List<String> dateofcreation;

  const AddNote( this.notes, this.title, this.dateofcreation);

  @override
  List<Object> get props => [notes,title,dateofcreation];
}

class EditNote extends NoteEvent {
  final int index;
  final List<String> updatedNote;
   final List<String> updatedtitle;

  const EditNote(this.index, this.updatedNote,this.updatedtitle);

  @override
  List<Object> get props => [index, updatedNote,updatedtitle];
}

class DeleteNote extends NoteEvent {
  final int index;

  const DeleteNote(this.index);

  @override
  List<Object> get props => [index];
}