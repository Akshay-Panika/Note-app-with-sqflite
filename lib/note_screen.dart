import 'package:flutter/material.dart';
import 'package:note_app_with_sqflite/update_note_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'add_note_screen.dart';


class NoteScreen extends StatefulWidget {
  @override
  _NoteScreenState createState() => _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  late Database _database;
  late List<Map<String, dynamic>> _notes;

  @override
  void initState() {
    super.initState();
    _notes = [];
    _initializeDatabase();
  }

  Future<void> _initializeDatabase() async {
    final database = openDatabase(
      join(await getDatabasesPath(), 'notes_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, content TEXT)',
        );
      },
      version: 1,
    );
    _database = await database;
    _refreshNotes();
  }

  Future<void> _refreshNotes() async {
    final List<Map<String, dynamic>> notes = await _database.query('notes');
    setState(() {
      _notes = notes;
    });
  }

  Future<void> _deleteNote(int id) async {
    await _database.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id],
    );
    _refreshNotes();
  }

  int _calculateTotalNotes() {
    return _notes.length;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes app with sqflite'),
        actions:  [
          Center(child: Text('${_calculateTotalNotes()}',style: const TextStyle(color: Colors.white,fontSize: 19),)),
          const SizedBox(width: 25,)
        ],
      ),
      body: _notes.isEmpty
          ? const Center(child: Text('No notes added yet'))
          : ListView.builder(
        itemCount: _notes.length,
        itemBuilder: (context, index) {
          final note = _notes[index];
          int count=1;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              shape: const OutlineInputBorder(borderSide: BorderSide(color: Colors.blue,width: 1,)),
              leading: CircleAvatar(child: Text('${index+count}'),),
              title: Text(note['title']),
              subtitle: Text(note['content']),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateNoteScreen(
                            database: _database,
                            note: note,
                            onUpdate: () => _refreshNotes(),
                          ),
                        ),
                      );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _deleteNote(note['id']);

                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddNoteScreen(
                database: _database,
                onAdd: () => _refreshNotes(),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
