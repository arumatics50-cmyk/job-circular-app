import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'services/bookmark_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BookmarkService().init();
  runApp(const JobCircularApp());
}

class JobCircularApp extends StatelessWidget {
  const JobCircularApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'চাকরির খবর - Job Circular App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00796B), // Deep Emerald Teal
          primary: const Color(0xFF00796B),
          secondary: const Color(0xFF0288D1),
          surface: const Color(0xFFF8FAF9),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF00796B),
          foregroundColor: Colors.white,
          centerTitle: false,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
