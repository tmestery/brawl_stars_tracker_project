import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';  // importing different fonts from google-fonts

void main() {  // this is what happens before the app starts
  runApp(MyApp());
  initializeSomething();
}

void initializeSomething() { // prints initializing... while the app is loading into terminal
  print("Initializing...");
}

class MyApp extends StatelessWidget {   // mainly sets up themes, navigation, and routing
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LeaderboardPage()), // Fixed here
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

class HomePage extends StatelessWidget {   // represents a seperates screen, in this case homepage, inside the app! (User Interface for page)
  @override
  Widget build(BuildContext context) {  // tells flutter what to draw/make on UI
    return Scaffold(     // top level layout widget that acts as the blueprint for the screen
      backgroundColor: Colors.yellow.shade700, // Set background color here
      appBar: AppBar(      // adds a top navigation bar to the screen (property of scaffold)
        title: Text('BrawlKnawl'),
        centerTitle: true,
        backgroundColor: Colors.yellow.shade700, // changes AppBar color if (background)
      ),
      body: Center(      // defines the main screen content	(holds a lot)
        child: Column(   // holds a single widget inside another widget
          mainAxisAlignment: MainAxisAlignment.center,
          children: [  // children used because there is multiple widgets inside the parent function
            Text(
              'Welcome to BrawlKnawl!',
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Created by Tyler Mestery, and Mason Hart',   // contributers
              style: TextStyle(fontSize: 26),
            ),
          ],
        ),
      ),
    );
  }
}

/**
* Leadboard page that can be traveled to - from to below:
* Seperate screen basically
*/
class LeaderboardPage extends StatelessWidget {   // represents a separate screen, in this case, the leaderboard page
  @override
  Widget build(BuildContext context) {    // tells flutter what to draw/make on UI
    return Scaffold(
      backgroundColor: Colors.blueGrey, // Added missing comma
      body: Center(
        child: Column( // Column allows multiple children inside Center
          mainAxisSize: MainAxisSize.min, // Keeps content centered in display
          children: [
            Text(
              'Leaderboard',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ); // Closed Scaffold properly
  }
}


/**
* Events page that can be traveled to - from to below:
* Seperate screen basically
*/
class EventsPage extends StatelessWidget {   // represents a separate screen, in this case, the leaderboard page
  @override
  Widget build(BuildContext context) {    // tells flutter what to draw/make on UI
    return Scaffold(
      backgroundColor: Colors.blueGrey, // Added missing comma
      body: Center(
        child: Column( // Column allows multiple children inside Center
          mainAxisSize: MainAxisSize.min, // Keeps content centered in display
          children: [
            Text(
              'Events',
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    ); // Closed Scaffold properly
  }
}