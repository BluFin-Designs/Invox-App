import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard(
      {required this.colour,
      required this.text_colour,
      required this.title,
      required this.title2,
      required this.graph,
      required this.text,
      required this.bottom_text,
      required this.bottom_text2});
  final String title;
  final String title2;
  final Widget graph;
  final String text;
  final String bottom_text;
  final String bottom_text2;
  final Color colour;
  final Color text_colour;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220.0,
      margin: const EdgeInsets.only(
          left: 20.0, top: 20.0, right: 0.0, bottom: 15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: colour,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            Text(
              title2,
              style: const TextStyle(color: Colors.white, fontSize: 15.0),
            ),
            SizedBox(
              height: 60.0,
            ),
            Container(
              child: graph,
              height: 10.0,
            ),
            SizedBox(
              height: 60.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  text,
                  style: const TextStyle(fontSize: 20.0, color: Colors.white),
                ),
                Text(
                  bottom_text,
                  style: TextStyle(fontSize: 20.0, color: text_colour),
                ),
                Text(
                  bottom_text2,
                  style: const TextStyle(fontSize: 16.0, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
