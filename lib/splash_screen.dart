import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'main.dart'; // Ana sayfayı (MoodHomePage) kullanmak için

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // This method performs a smooth page transition.
  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        // Transition duration is set to 1 second
        transitionDuration: const Duration(milliseconds: 1000),
        // The page to be shown at the end of the transition
        pageBuilder: (context, animation, secondaryAnimation) =>
            const MoodHomePage(),
        // Define the transition animation (slide effect)
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Define a slide animation from bottom to top
          const begin = Offset(
            0.0,
            1.0,
          ); // Starts from the bottom of the screen
          const end = Offset.zero; // Ends at the center of the screen
          const curve = Curves.ease; // Animation speed and smoothness

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // The animation covers the background
          SizedBox.expand(
            child: Lottie.asset(
              'assets/emojis/splash_animation.json',
              fit: BoxFit.contain,
              repeat: true,
            ),
          ),
          // Title and subtitle, stacked vertically in the upper part of the screen
          const Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: 80.0), // Top padding
              child: Column(
                mainAxisSize: MainAxisSize.min, // Wrap content vertically
                children: [
                  Text(
                    'MoodSay',
                    style: TextStyle(
                      color: Colors.black, // Title color is black
                      fontSize: 60,
                      fontWeight: FontWeight.w900, // Thicker font weight
                      fontStyle: FontStyle.italic, // Italic font style
                    ),
                  ),
                  SizedBox(height: 10), // Spacing between title and subtitle
                  Text(
                    'Biraz gülümse, biraz düşün, biraz hisset.', // Yeni ve güncellenmiş alt yazı
                    style: TextStyle(
                      color: Colors.black, // Subtitle color is black
                      fontSize: 17, // Yeni font boyutu
                      fontWeight:
                          FontWeight.w900, // Same font weight as the title
                      fontStyle:
                          FontStyle.italic, // Same font style as the title
                    ),
                  ),
                ],
              ),
            ),
          ),
          // A gesture detector covering the whole screen to navigate to the home page
          GestureDetector(
            onTap: _navigateToHome,
            child: Container(color: Colors.transparent),
          ),
        ],
      ),
    );
  }
}
