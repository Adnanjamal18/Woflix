import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:woflix/screens/detailsscreen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final gradient = LinearGradient(colors: [
     const Color.fromARGB(255, 218, 219, 219),
     Colors.orangeAccent,
     const Color.fromARGB(255, 80, 2, 2)
  ]);
  List movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    final response = await http.get(Uri.parse('https://api.tvmaze.com/search/shows?q=all'));
    if (response.statusCode == 200) {
      setState(() {
        movies = json.decode(response.body);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( 
        leading: ClipRRect(borderRadius: BorderRadius.circular(25.0),
        child: Image.asset('assets/movie_splash.jpg',),
        ),
        title: ShaderMask(
          shaderCallback: (bounds) => gradient.createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
          child: RichText(text: TextSpan(text: 'WooFlix',style: TextStyle(
            fontWeight: FontWeight.w900,
            shadows: [Shadow(color: Colors.grey)]
           ))),
        ),
        actions: [
          Row(
         children: [
          IconButton(onPressed: (){}, icon: Icon(Icons.cast)),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.of(context).pushNamed('/search');
              },
            ),
         ],
          ),
        ],
      ),
      body: movies.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                var movie = movies[index]['show'];
                return Card(
                  margin: EdgeInsets.all(4),
                  elevation: 20,
                  child: ListTile(
                    leading: Image.network(movie['image'] != null ? movie['image']['medium'] : ''),
                    title: Text(movie['name']),
                    subtitle: Text(movie['summary'] ?? 'No summary available'),
                    onTap: () {
                      Navigator.of(context).pushNamed('/details', arguments: movie);
                    },
                  ),
                );
              },
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.of(context).pushNamed('/search');
          }
        },
      ),
    );
  }
}
