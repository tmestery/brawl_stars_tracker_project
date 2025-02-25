// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';  // importing different fonts from google-fonts

// run it using "flutter run --release" instead of "flutter run"
// opening specific simulator device: "open -a Simulator --args -CurrentDeviceUDID $(xcrun simctl list devices | grep 'iPhone 12' | awk '{print $NF}' | head -n1)"

import 'package:flutter/material.dart';
import 'leaderboardDisplay.dart';
import 'clubLeaderboardDisplay.dart';
import 'currentEvents.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String leaderboardText = "Loading...";  // Initially, show loading text
  String clubLeaderboardText = "Loading..."; // Initially, show loading text
  String brawlEventsText = "Loading..."; // Initially, show loading text

  @override
  void initState() {
    super.initState();
    runDartScript();  // get rankings as soon as the app starts
  }

  // function to run the Dart script and fetch leaderboard data
  Future<void> runDartScript() async {
    try {
      // call the function from leaderboardDisplay.dart to get the rankings
      List<String> leaderboard = await getGlobalLeaderboard();
      List<String> clubLeaderboard = await getGlobalClubLeaderboard();
      List<String> brawlEvents = await getCurrentEvents();

      // convert the leaderboard list to a plain text string
      String text = leaderboard.join('\n');  // merge items into string
      String text2 = clubLeaderboard.join('\n');  // merge items into string
      String text3 = brawlEvents.join('\n\n');  // merge items into string


      setState(() {
        leaderboardText = text;  // update text for display
        clubLeaderboardText = text2;  // update text for display
        brawlEventsText = text3;  // update text for display

      });
    } catch (e) {
      setState(() {
        leaderboardText = 'Error: $e';  // error message
        clubLeaderboardText = 'Error: $e';  // error message
        brawlEventsText =  'Error: $e';  // error message
      });
    }
  }

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
                style: TextStyle( // applies default fonts, used to be google fonts
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
                  Navigator.push(  // add navigation to the EventsPage here
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardPage(
                        leaderboardText: leaderboardText,
                        clubLeaderboardText: clubLeaderboardText,
                      ),
                    ),
                  );
                },  
                child: Text(
                  'Leaderboards',
                  style: TextStyle( // this applies the default system font
                    //style: GoogleFonts.montserrat(
                    fontSize: width / 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade100,
                  ),
                ),
              ),
            ),
            Builder(  // ensures the correct context for Navigator bar
              builder: (context) => TextButton(  // adding a button that's click-able
                onPressed: () {
                  print('Events clicked');
                  Navigator.push(  // adds navigation to the EventsPage
                    context,
                    MaterialPageRoute(builder: (context) => EventsPage(brawlEventsText: brawlEventsText)),  // opens EventsPage when clicked
                  );
                },
                child: Text(
                  'Events',
                  style: TextStyle( // this applies the default system font
                    //style: GoogleFonts.montserrat( // same font
                    fontSize: width / 34,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade100,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(   // holds 'MAIN' content of screen -> as in decoration, padding, colors, etc.
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
                  style: TextStyle( 
                    //style: GoogleFonts.bangers(  // applying google-fonts -> again
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
  final String leaderboardText;
  final String clubLeaderboardText;

  // constructor to receive the leaderboardText and clubLeaderboardText
  LeaderboardPage({
    required this.leaderboardText,
    required this.clubLeaderboardText,
    });

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
                Navigator.pop(context); // user Navigator.pop to go back to other screen when pressed
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Leaderboard',
              style: TextStyle(
                fontSize: width / 15,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
              physics: BouncingScrollPhysics(), // sick feature, makes it bounce when you scroll to far
                child: Text(
                  leaderboardText,  // display leaderboard text with proper wrapping (total trophy leadeboard)
                  style: TextStyle(
                    fontSize: width / 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
              physics: BouncingScrollPhysics(), // sick feature, makes it bounce when you scroll to far
                child: Text(
                  clubLeaderboardText,  // display leaderboard text with proper wrapping (total CLUB trophy leadeboard)
                  style: TextStyle(
                    fontSize: width / 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventsPage extends StatelessWidget {
  final String brawlEventsText;

  // constructor to receive the eventsText
  EventsPage({required this.brawlEventsText});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text(
              'Your one-stop shop for everything Brawl Stars!',  // slogan
              style: TextStyle(
                fontSize: width / 46,
                fontWeight: FontWeight.bold,
                color: Colors.teal.shade100,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 5),
          ],
        ),
        backgroundColor: Colors.black,
        centerTitle: true,
        actions: [
          Builder(
            builder: (context) => TextButton(
              onPressed: () {
                Navigator.pop(context);
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
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(   // adding a gradient to the page
                colors: [Colors.tealAccent, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ).createShader(bounds);
            },
            child: Text(
              'Current Events', // title text at top of page
              style: TextStyle(
                fontSize: width / 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    color: Colors.black.withOpacity(0.3),
                    offset: Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: height * 0.03),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: width * 0.07),
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blueGrey.shade800, Colors.black87],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.tealAccent, width: 2),
                boxShadow: [
                  BoxShadow(    // adds a shadow feature
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 8,
                    offset: Offset(2, 4),  // amount of offset the shadow has
                  ),
                ],
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(), // sick feature, makes it bounce when you scroll to far
                child: Text(
                  brawlEventsText,
                  style: TextStyle(
                    fontSize: width / 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 0.5,
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}