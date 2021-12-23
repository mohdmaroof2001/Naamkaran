// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:naamkaran/pages/babycategory.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreenView(
        navigateRoute: BoysandGirls(),
        duration: 5000,
        backgroundColor: Colors.white,
        imageSrc: "images/baby.gif",
        imageSize: 400,
      ),
    );
  }
}
