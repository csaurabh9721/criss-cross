import 'dart:async';

import 'package:cris_crass_game/game_page.dart';
import 'package:flutter/material.dart';

import 'app_color.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const GamePage()));
    });
    super.initState();
  }

  final AppColors _colors = AppColors();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image:
              AssetImage('assets/Black Minimalist Believe Phone Wallpaper.png'),
          fit: BoxFit.fill,
        )),
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.25,
            ),
            Container(
              height: 140,
              width: 140,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: _colors.white,
                borderRadius: BorderRadius.circular(70),
                boxShadow: [
                  BoxShadow(
                    color: _colors.white.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(-4, -4),
                  ),
                  BoxShadow(
                    color: _colors.white.withOpacity(0.4),
                    blurRadius: 16,
                    offset: const Offset(6, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(70),
                child: Image.asset('assets/tic-tac-toe.gif'),
              ),
            ),
            const Spacer(),
            const Text(
              "Developed by",
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 12),
            ),
            const Text(
              "Saurabh Chauhan",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
            const Text(
              "(https://saurabhchauhaportfolio.000webhostapp.com/#/)",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
