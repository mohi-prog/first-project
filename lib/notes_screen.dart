import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:learnconnectmyself/main.dart';
import 'firestore_service.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        leading: BackButton(color: Colors.blue),
        flexibleSpace: Stack(
          children: [
            Positioned(
              top: 30,
              left: 265,
              child: Text(
                'My Notes',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 30,
                  fontFamily: 'Jersey',
                ),
              ),
            ),
          ],
        ),
      ),
      body: MainNotesScreen(),
      backgroundColor: const Color.fromARGB(255, 15, 123, 200),
    );
  }
}

class MainNotesScreen extends StatefulWidget {
  const MainNotesScreen({super.key});

  @override
  State<MainNotesScreen> createState() => _MainNotesScreenState();
}

class _MainNotesScreenState extends State<MainNotesScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final TextEditingController _noteTitleController = TextEditingController();
  final TextEditingController _noteContentController = TextEditingController();
  String previewText(String text, {int maxWords = 15}) {
    final words = text.split(RegExp(r'\s+'));
    if (words.length <= maxWords) return text;
    return words.take(maxWords).join(' ') + '...';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          top: 100,
          bottom: 100,
          child: StreamBuilder<QuerySnapshot>(
            stream: _firestoreService.getUserNotes(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Opacity(
                    opacity: 0.7,
                    child: Text(
                      'Click + to add a note\nYour notes will appear here',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.amber,
                        fontSize: 22,
                        fontFamily: 'Jersey',
                      ),
                    ),
                  ),
                );
              }

              final notes = snapshot.data!.docs;

              return ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  final doc = notes[index];
                  final data = doc.data() as Map<String, dynamic>;

                  return Card(
                    color: Colors.amber,
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      onTap: () {
                        _showEditDialog(
                          noteId: doc.id,
                          oldTitle: data['title'],
                          oldContent: data['content'],
                        );
                      },

                      title: Text(
                        data['title'] ?? '',
                        style: const TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        previewText(data['content'] ?? ''),
                        style: const TextStyle(color: Colors.blue),
                      ),

                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.blue),
                        onPressed: () {
                          _firestoreService.deleteNote(doc.id);
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),

        Positioned(
          bottom: 20,
          left: 305,
          width: 60,
          height: 60,
          child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  backgroundColor: Colors.amber,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Add Note',
                            style: TextStyle(fontSize: 24, color: Colors.blue),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _noteTitleController,

                            decoration: InputDecoration(
                              hintText: 'Title',
                              hintStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          TextField(
                            controller: _noteContentController,
                            maxLines: 5,
                            
                            maxLength: 20,
                            decoration: InputDecoration(
                              hintText: 'Content',
                              hintStyle: TextStyle(color: Colors.blue),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Colors.blue,
                                  width: 4,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () async {
                                // Hier später Firebase Code
                                await _firestoreService.createNote(
                                  title: _noteTitleController.text.trim(),
                                  content: _noteContentController.text.trim(),
                                );

                                _noteTitleController.clear();
                                _noteContentController.clear();

                                if (!mounted) return;
                                Navigator.pop(context);
                                await _firestoreService.getUserNotes();
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.blue,
                              ),
                              child: Text('Save'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
            ),
            child: Icon(Icons.add, color: Colors.blue, size: 40),
          ),
        ),
      ],
    );
  }

  void _showEditDialog({
    required String noteId,
    required String oldTitle,
    required String oldContent,
  }) {
    final titleController = TextEditingController(text: oldTitle);
    final contentController = TextEditingController(text: oldContent);
    final FirestoreService _firestoreService = FirestoreService();

    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Edit Note',
                  style: TextStyle(fontSize: 24, color: Colors.blue),
                ),
                const SizedBox(height: 16),

                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 4,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextField(
                  controller: contentController,
                  maxLines: 5,
                  decoration: InputDecoration(
                    hintText: 'Content',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(
                        color: Colors.blue,
                        width: 4,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    onPressed: () async {
                      await _firestoreService.updateNote(
                        noteId: noteId,
                        title: titleController.text.trim(),
                        content: contentController.text.trim(),
                      );

                      if (!mounted) return;
                      Navigator.pop(context);
                    },
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Firebase Service - FERTIG von mir
