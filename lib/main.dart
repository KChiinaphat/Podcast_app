import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:podcast_app/screens/podcast_list_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print("Firebase initialized successfully");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Podcast App',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple, 
        scaffoldBackgroundColor: Colors.grey[100], 
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepPurple[700], 
          elevation: 2, 
          titleTextStyle: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white, 
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurple, 
          foregroundColor: Colors.white,
          elevation: 6, 
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), 
          ),
          filled: true,
          fillColor: Colors.white,
          labelStyle: TextStyle(color: Colors.grey[600]),
        ),
      ),
      initialRoute: '/splash', 
      routes: {
        '/splash': (context) => SplashScreen(),
        '/podcastList': (context) => PodcastListScreen(),
      },
    );
  }
}


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/podcastList');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.deepPurple[700]!, Colors.deepPurple[400]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.mic, 
                size: 100,
                color: Colors.white,
              ),
              SizedBox(height: 20),
              Text(
                'Podcast App',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black26,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 4,
              ),
            ],
          ),
        ),
      ),
    );
  }
}