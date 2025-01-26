import 'package:flutter/material.dart';
import 'screens/splash_screen.dart'; // First splash screen
import 'screens/login_screens.dart'; // Login screen
import 'screens/calender_screen.dart';
import 'screens/tracker_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideAtlas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // First splash screen is shown here
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/calender':(context)=> const CalendarViewPage(),
        '/tracker':(context)=>const TrackingDetailsPage(),
},
);
}
}