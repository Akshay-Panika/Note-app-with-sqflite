import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class UpdateNoteScreen extends StatefulWidget {
  final Database database;
  final Map<String, dynamic> note;
  final VoidCallback onUpdate;

  const UpdateNoteScreen({required this.database, required this.note, required this.onUpdate});

  @override
  _UpdateNoteScreenState createState() => _UpdateNoteScreenState();
}

class _UpdateNoteScreenState extends State<UpdateNoteScreen> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note['title']);
    _contentController = TextEditingController(text: widget.note['content']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Note'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            SizedBox(height: 12.0),
            TextField(
              controller: _contentController,
              decoration: const InputDecoration(
                labelText: 'Content',
              ),
              maxLines: null,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text;
                final content = _contentController.text;
                _updateNote(widget.note['id'], title, content);
              },
              child: Text('Update'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _updateNote(int id, String title, String content) async {
    await widget.database.update(
      'notes',
      {'title': title, 'content': content},
      where: 'id = ?',
      whereArgs: [id],
    );
    widget.onUpdate();
    Navigator.pop(context);
  }
}
