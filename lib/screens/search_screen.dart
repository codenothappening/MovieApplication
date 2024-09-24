import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_learn/screens/detail_screen.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];
  final TextEditingController _controller = TextEditingController();

  searchMovies(String query) async {
    final response = await http
        .get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    } else {
      throw Exception("Failed to load search results");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Search for a movie...',
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    searchMovies(_controller.text);
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: searchResults.isEmpty
                ? Center(child: Text('No results found'))
                : ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      var movie = searchResults[index]['show'];
                      return ListTile(
                        leading: Image.network(movie['image'] != null
                            ? movie['image']['medium']
                            : 'https://via.placeholder.com/150'),
                        title: Text(movie['name']),
                        subtitle: Text(movie['summary'] != null
                            ? movie['summary']
                                .replaceAll(RegExp(r'<[^>]*>'), '')
                            : 'No summary available'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    DetailsScreen(movie: movie)),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
