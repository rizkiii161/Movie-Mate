import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addMovie(String title, String genre, int year, double rating) async {
    await _db.collection('movies').add({
      'title': title,
      'genre': genre,
      'year': year,
      'rating': rating,
      'created_at': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<Map<String, dynamic>>> getMovies() {
    return _db.collection('movies').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'],
          'genre': doc['genre'],
          'year': doc['year'],
          'rating': doc['rating'],
        };
      }).toList();
    });
  }
}
