import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final movie = ModalRoute.of(context)!.settings.arguments as Map;

    return Scaffold(
      appBar: AppBar(
        title: Text(movie['name']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            movie['image'] != null
                ? Image.network(movie['image']['medium'])
                : Placeholder(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie['summary'] ?? 'No summary available',
                style: TextStyle(fontSize: 16),
              ),
            ),
            // Add other details as needed from the movie object
          ],
        ),
      ),
    );
  }
}
