import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({required this.icon, required this.text, required this.onPress});
  final String icon;
  final String text;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 60.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 30.0,
            ),
            Image(image: AssetImage(icon), height: 38.0, width: 38.0),
            SizedBox(
              width: 20.0,
            ),
            Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
            )
          ],
        ),
        margin: EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
        ),
      ),
    );
  }
}
