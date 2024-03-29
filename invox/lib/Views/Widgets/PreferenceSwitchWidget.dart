import 'package:flutter/material.dart';

class PreferenceSwitchWidget extends StatefulWidget {
  bool switchValue;
  String title;
  VoidCallback? onChanged;

  PreferenceSwitchWidget({
    this.switchValue = false,
    this.title = "default",
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<PreferenceSwitchWidget> createState() => _PreferenceSwitchWidgetState();
}

class _PreferenceSwitchWidgetState extends State<PreferenceSwitchWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xffF0F5FF),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  color: Color(0xff0A2647),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Switch.adaptive(
                value: widget.switchValue,
                onChanged: (bool val) {
                  setState(() {
                    widget.switchValue = val;
                  });
                },
                thumbColor: MaterialStateProperty.all(
                  Theme.of(context).primaryColor,
                ),
                activeColor: const Color(0xff91D8E4),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
