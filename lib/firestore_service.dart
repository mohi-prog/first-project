import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Aktueller User
  User? get currentUser => FirebaseAuth.instance.currentUser;

  /// CREATE: Note erstellen
  Future<void> createNote({
    required String title,
    required String content,
  }) async {
    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('notes')
          .add({
            'title': title,
            'content': content,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });

      print('✅ Note created successfully');
    } catch (e) {
      print('❌ Error creating note: $e');
      throw Exception('Failed to create note');
    }
  }

  /// READ: Alle Notes des Users (Echtzeit-Stream)
  Stream<QuerySnapshot> getUserNotes() {
    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    return _firestore
        .collection('users')
        .doc(currentUser!.uid)
        .collection('notes')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// UPDATE: Note aktualisieren
  Future<void> updateNote({
    required String noteId,
    required String title,
    required String content,
  }) async {
    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('notes')
          .doc(noteId)
          .update({
            'title': title,
            'content': content,
            'updatedAt': FieldValue.serverTimestamp(),
          });

      print('✅ Note updated successfully');
    } catch (e) {
      print('❌ Error updating note: $e');
      throw Exception('Failed to update note');
    }
  }

  /// DELETE: Note löschen
  Future<void> deleteNote(String noteId) async {
    if (currentUser == null) {
      throw Exception('User not logged in');
    }

    try {
      await _firestore
          .collection('users')
          .doc(currentUser!.uid)
          .collection('notes')
          .doc(noteId)
          .delete();

      print('✅ Note deleted successfully');
    } catch (e) {
      print('❌ Error deleting note: $e');
      throw Exception('Failed to delete note');
    }
  }
}
