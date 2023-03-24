import 'package:flutter/material.dart';

class PreferenceButtonWidget extends StatelessWidget {
  final VoidCallback? onClick;
  final IconData? icon;
  final String? title;

  const PreferenceButtonWidget({
    this.onClick,
    this.icon = Icons.category,
    this.title = "Default",
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 65,
          decoration: BoxDecoration(
            color: const Color(0xffC1C1C1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon!,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      title!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.arrow_forward_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
