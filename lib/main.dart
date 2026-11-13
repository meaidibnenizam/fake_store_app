import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

/// The entry point of every Flutter app.
///
/// `void main()` is the first function that runs when the app starts.
/// It creates the app and attaches it to the screen.
void main() {
  // `runApp` takes a widget and puts it at the root of the widget tree.
  runApp(const FakeStoreApp());
}

/// The root widget of the app.
///
/// It is `Stateless` because the app's overall structure (theme, routes)
/// does not change after it is created.
class FakeStoreApp extends StatelessWidget {
  const FakeStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp provides Material Design theming, navigation, and routes.
    return MaterialApp(
      title: 'Fake Store',
      debugShowCheckedModeBanner: false,

      // Light theme for the whole app.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),

      // The first screen the user sees.
      home: const SplashScreen(),
    );
  }
}
