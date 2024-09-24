import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final dynamic movie;

  DetailsScreen({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['medium'])
                : Image.network('https://via.placeholder.com/150'),
            SizedBox(height: 10),
            Text(
              movie['name'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(movie['summary'] != null
                ? movie['summary'].replaceAll(RegExp(r'<[^>]*>'), '')
                : 'No summary available'),
            // Add more fields if needed like genres, language, etc.
          ],
        ),
      ),
    );
  }
}
