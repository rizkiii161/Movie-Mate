import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyMoviesScreen extends StatefulWidget {
  const MyMoviesScreen({super.key});

  @override
  State<MyMoviesScreen> createState() => _MyMoviesScreenState();
}

class _MyMoviesScreenState extends State<MyMoviesScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> _updateMovieStatus(String docId, String newStatus) async {
    await _firestore.collection('movies').doc(docId).update({'status': newStatus});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: _firestore.collection('movies').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("No movies added yet"));
          }

          Map<String, List<QueryDocumentSnapshot>> categorizedMovies = {
            'Watching': [],
            'Watched': [],
            'Will Watch': [],
          };

          for (var doc in snapshot.data!.docs) {
            String status = doc['status'];
            if (categorizedMovies.containsKey(status)) {
              categorizedMovies[status]!.add(doc);
            }
          }

          return ListView(
            children: categorizedMovies.entries.map((entry) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      entry.key,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Column(
                    children: entry.value.map((movie) {
                      return ListTile(
                        title: Text(movie['title']),
                        subtitle: Text("Status: ${movie['status']}"),
                        trailing: PopupMenuButton<String>(
                          onSelected: (newStatus) => _updateMovieStatus(movie.id, newStatus),
                          itemBuilder: (context) => ['Watching', 'Watched', 'Will Watch']
                              .where((status) => status != movie['status'])
                              .map((status) => PopupMenuItem(
                                    value: status,
                                    child: Text("Move to $status"),
                                  ))
                              .toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
