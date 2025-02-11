import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // importing different fonts from google-fonts

void main() {
  runApp(MyApp());  // Ensuring that your app starts correctly.
}

class MyApp extends StatefulWidget {   // Changed to StatefulWidget to hold leaderboardString
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String leaderboardString = ''; // Initialize leaderboardString

  @override
  Widget build(BuildContext context) {   // tells flutter what to draw/make on UI
    return MaterialApp(
      home: Scaffold(   // top level layout widget that acts as the blueprint for the screen
        appBar: AppBar(    // adds a top navigation bar to the screen (property of scaffold)
          title: Column(  // Fixed here to use Column for multiple widgets
            children: [
              Text(
                'Your one-stop shop for everything brawlstars!',
                style: GoogleFonts.montserrat(  // applying the fonts from google-fonts
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade100,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white, // appbar color is here
          actions: [
            Builder(  // Ensuring correct context for Navigator
              builder: (context) => TextButton( 
                onPressed: () {
                  print('Leaderboard clicked');
                  Navigator.push(  // Added navigation to the EventsPage
                    context,
                    MaterialPageRoute(builder: (context) => LeaderboardPage()),  // Open EventsPage when clicked
                  );
                },  
                child: Text(
                  'Leaderboards',
                  style: GoogleFonts.montserrat(  // using the same font as the slogan
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade100,
                  ),
                ),
              ),
            ),
            Builder(  // Ensuring correct context for Navigator
              builder: (context) => TextButton(  // adding a button that's pressable
                onPressed: () {
                  print('Events clicked');
                  Navigator.push(  // Added navigation to the EventsPage
                    context,
                    MaterialPageRoute(builder: (context) => EventsPage()),  // Open EventsPage when clicked
                  );
                },
                child: Text(
                  'Events',
                  style: GoogleFonts.montserrat(  // using the same font as the slogan
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade100,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(   // container holds MAIN content of screen, as in decoration, padding, colors, etc.
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightBlue.shade100, Colors.yellow.shade100], 
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(   // using child to define centered text
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [   // again, here children is used since there's style, fontsize, weight, and color = more than one widget
                Text(
                  'BrawlKnawl',
                  style: GoogleFonts.bangers(  // applying google-fonts again
                    fontSize: 175,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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

class LeaderboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Leaderboard',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Events',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}