import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:note_app/note_model.dart';

class NoteController extends GetxController {
  List<Note?> notes = [];

  Future<void> addNote(String text) async {
    final box = await Hive.openBox('notesBox');
    final note = Note(
      text: text,
      createdAt: DateTime.now(),
    );

    notes.add(note);
    await box.put('notes', notes.map((n) => n?.toJson()).toList());
    update();
  }

  Future<void> loadNotes() async {
    final box = await Hive.openBox('notesBox');
    final rawNotes = box.get('notes', defaultValue: []);

    notes = (rawNotes as List)
        .map((note) {
          if (note is Map) {
            final castedNote = Map<String, dynamic>.from(note);
            return Note.fromJson(castedNote);
          } else {
            print("Invalid note format: $note");
            return null;
          }
        })
        .where((note) => note != null)
        .toList();

    update();
  }

  Future<void> deleteNote(int index) async {
    final box = await Hive.openBox('notesBox');
    notes.removeAt(index);
    await box.put('notes', notes.map((n) => n?.toJson()).toList());
    update();
  }
}
