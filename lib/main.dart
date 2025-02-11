// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';  // importing different fonts from google-fonts

import 'dart:io';
import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'leaderboardDisplay.py';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runPythonScript();  // Execute Python before launching UI
  runApp(MyApp());
}

void runPythonScript() async {
  // Define the Python script file path
  final scriptPath = '/Users/tmestery/brawl_tracker/lib/leaderboardDisplay.py';
  
  // Run the Python script using Process
  ProcessResult results = await Process.run('/opt/homebrew/bin/python3', [scriptPath]);
  //ProcessResult results = await Process.run('sudo', ['python3', scriptPath]);
  var decode = (jsonDecode(results.stdout));
  print(decode); // Decode JSON before printing
}

// Convert MyApp to a StatefulWidget
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // String leaderboardString = ''; // Initialize leaderboardString

  @override
  Widget build(BuildContext context) {   // tells flutter what to draw/make on UI
  double width = MediaQuery.sizeOf(context).width;
    return MaterialApp(
      home: Scaffold(   // top level layout widget that acts as the blueprint for the screen
        appBar: AppBar(    // adds a top navigation bar to the screen (property of scaffold)
          title: Column(  // Fixed here to use Column for multiple widgets
            children: [
              Text(
                'Your one-stop shop for everything brawlstars!',
                //style: GoogleFonts.montserrat(  // applying the fonts from google-fonts
                style: TextStyle( // This applies the default system font
                  fontSize: width / 46,
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
                  style: TextStyle( // This applies the default system font
                  //style: GoogleFonts.montserrat(  // using the same font as the slogan
                    fontSize: width / 34,
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
                  style: TextStyle( // This applies the default system font
                  //style: GoogleFonts.montserrat(  // using the same font as the slogan
                    fontSize: width / 34,
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
                  'BrawlKnawl', // Concatenating the two strings
                  style: TextStyle( // This applies the default system font
                  //style: GoogleFonts.bangers(  // applying google-fonts again
                    fontSize: width / 8,
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
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Your one-stop shop for everything brawlstars!',
              style: TextStyle(
                fontSize: width / 46,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade100,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          Builder(
            builder: (context) => TextButton(
              onPressed: () {
                Navigator.pop(context); // Use Navigator.pop to go back
              },
              child: Text(
                'Back',
                style: TextStyle(
                  fontSize: width / 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade100,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: width / 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
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
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Your one-stop shop for everything brawlstars!',
              style: TextStyle(
                fontSize: width / 46,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade100,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.white,
        actions: [
          Builder(
            builder: (context) => TextButton(
              onPressed: () {
                Navigator.pop(context); // Use Navigator.pop to go back
              },
              child: Text(
                'Back',
                style: TextStyle(
                  fontSize: width / 34,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal.shade100,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.blueGrey,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Events',
              style: TextStyle(
                fontSize: width / 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}