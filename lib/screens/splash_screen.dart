import 'package:flutter/material.dart';
import 'home_screen.dart';

/// The Splash Screen shown when the app first opens.
///
/// It displays the app logo/name and after 2 seconds automatically navigates
/// to the Home Screen using `Navigator.pushReplacement`.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// We need a State class because we use `initState` and a `Timer`
/// to delay the navigation.
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Wait 2 seconds, then go to the Home screen.
    Future.delayed(const Duration(seconds: 2), () {
      // `mounted` checks that the widget is still on screen before navigating.
      // Without this check, if the user left the splash early, Flutter would throw.
      if (!mounted) return;

      // pushReplacement replaces the splash with HomeScreen, so the user
      // cannot go "back" to the splash screen.
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade700,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Icon(
                Icons.shopping_bag,
                size: 72,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Fake Store',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Product Catalog',
              style: TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(color: Colors.white),
          ],
        ),
      ),
    );
  }
}
