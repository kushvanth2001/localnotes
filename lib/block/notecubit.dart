import 'package:equatable/equatable.dart';

abstract class NoteCubitState extends Equatable {
   final List<String> notes;
  final List<String> title;
  final List<String> dateofcreation;

  const NoteCubitState({
    required this.notes,
    required this.title,
    required this.dateofcreation,
  });

  @override
  List<Object> get props => [notes,title,dateofcreation];
}

class NoteInitial extends NoteCubitState {
  NoteInitial({required super.notes, required super.title, required super.dateofcreation});


}

class NoteLoading extends NoteCubitState {
  NoteLoading({required super.notes, required super.title, required super.dateofcreation});
}

class NoteLoaded extends NoteCubitState {
  final List<String> notes;
    final List<String> title;
      final List<String> dateofcreation;
  const NoteLoaded(this.notes, this.title, this.dateofcreation) : super(notes: notes, title: title, dateofcreation: dateofcreation);

  @override
  List<Object> get props => [notes,title,dateofcreation];
}