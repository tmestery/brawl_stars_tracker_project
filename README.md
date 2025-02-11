# Brawl Stars Tracker Project

## Description

The Brawl Stars Tracker is designed to give players insights into leaderboard positions, and events occuring within Brawlstars. Through using the official Brawl Stars API, the application collects real-time data, allowing users to:

- Monitor Leaderboard Standings Overtime
- Compare standings with friends or club members
- Checkout daily events occuring
- Details about recommended brawlers for different maps

This is achieved by leveraging the [Brawl Stars API](https://developer.brawlstars.com/).
The application is built using Flutter, ensuring compatibility across multiple platforms, including iOS, Android, and web browsers.

## How to Run the Project

To set up and run the Brawl Stars Tracker application locally, follow these steps:

1. **Clone the Repository**

   Open your terminal and run:

   ```bash
   git clone https://github.com/tmestery/brawl_stars_tracker_project.git
   cd brawl_stars_tracker_project
   ```

2. **Install Flutter**

   Ensure that [Flutter](https://flutter.dev/docs/get-started/install) is installed on your system. You can verify the installation by running:

   ```bash
   flutter --version
   ```

3. **Install Dependencies**

   Navigate to the project directory and install the required dependencies:

   ```bash
   flutter pub get
   ```

4. **Configure the Brawl Stars API**

   To access player data, you'll need an API key from the [Brawl Stars Developer Portal](https://developer.brawlstars.com/). After obtaining the key:

   - Create a file named `.env` in the root of the project.
   - Add your API key to this file:

     ```
     BRAWL_STARS_API_KEY=your_api_key_here
     ```

5. **Run the Application**

   Depending on your target platform:

   - **For Mobile (iOS/Android):**

     Connect your device or start an emulator (xcode, android studio, etc) then run:

     ```bash
     flutter run
     ```

   - **For Web:**

     Ensure you have a web browser installed, then run:

     ```bash
     flutter run -d chrome
     ```
     
If you have any issues or questions, reach out!
