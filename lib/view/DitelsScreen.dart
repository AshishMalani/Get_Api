import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class DitelsScreen extends StatefulWidget {
  final image;
  final name;

  const DitelsScreen({Key? key, required this.image, this.name})
      : super(key: key);

  @override
  State<DitelsScreen> createState() => _DitelsScreenState();
}

class _DitelsScreenState extends State<DitelsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(widget.image),
                ),
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FadeInUp(
                child: FadeInDownBig(
                  child: ZoomIn(
                    duration: Duration(seconds: 5),
                    child: Text(
                      widget.name.toString(),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
