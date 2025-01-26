import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/note_controller.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController textController = TextEditingController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NoteController controller = Get.put(NoteController());

    return Scaffold(
      appBar: AppBar(title: const Text("Notes App")),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<NoteController>(
              initState: (_) => controller.loadNotes(),
              builder: (controller) {
                return ListView.builder(
                  itemCount: controller.notes.length,
                  itemBuilder: (context, index) {
                    final note = controller.notes[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side: BorderSide(color: Colors.grey.shade300, width: 1),
                      ),
                      elevation: 2,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        title: Text(
                          note.text,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          "${note.createdAt.toLocal()}".split('.')[0],
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => controller.deleteNote(index),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                    decoration: const InputDecoration(
                      labelText: "اضف ملاحضة",
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      controller.addNote(textController.text);
                      textController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
