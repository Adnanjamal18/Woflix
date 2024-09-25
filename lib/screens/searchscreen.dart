import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List searchResults = [];

  void searchMovies(String query) async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=$query'));
    if (response.statusCode == 200) {
      setState(() {
        searchResults = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(hintText: 'Search Movies...'),
          onSubmitted: (query) {
            searchMovies(query);
          },
        ),
      ),
      body: searchResults.isEmpty
          ? Center(child: Text('Search for movies'))
          : ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                var movie = searchResults[index]['show'];
                return ListTile(
                  leading: Image.network(movie['image'] != null ? movie['image']['medium'] : ''),
                  title: Text(movie['name']),
                  subtitle: Text(movie['summary'] ?? 'No summary available'),
                  onTap: () {
                    Navigator.of(context).pushNamed('/details', arguments: movie);
                  },
                );
              },
            ),
    );
  }
}
