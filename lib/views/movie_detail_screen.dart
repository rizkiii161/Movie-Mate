import 'package:flutter/material.dart';
import 'package:movieslist/services/constans.dart';


class MovieDetailScreen extends StatelessWidget {
  final String title;
  final String genre;
  final String imageUrl;
  final String overview;

  const MovieDetailScreen({
    super.key,
    required this.title,
    required this.genre,
    required this.imageUrl,
    required this.overview,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kbackgroundcolor,
      appBar: AppBar(
        backgroundColor: kbackgroundcolor,
        title: Text(title, style: TextStyle(color: ktextcolor)),
        iconTheme: IconThemeData(color: ktextcolor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  imageUrl,
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                genre,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                "Overview",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ktextcolor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                overview,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[400],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}