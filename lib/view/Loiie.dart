import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Lotte extends StatefulWidget {
  const Lotte({Key? key}) : super(key: key);

  @override
  State<Lotte> createState() => _LotteState();
}

class _LotteState extends State<Lotte> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ZoomIn(
        duration: Duration(seconds: 2),
        child: Center(
          child: Lottie.asset(
            'assets/images/99969-healthcare-loader.json',
          ),
        ),
      ),
    );
  }
}
