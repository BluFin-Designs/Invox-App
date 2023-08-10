import 'package:flutter/material.dart';
import 'package:invox/Views/Screens/Preferences_Screen.dart';
import 'package:url_launcher/url_launcher.dart' as u;

import '../../Repositories/UserRepository.dart';

class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  dynamic launchBrowser(String link) async {
    try {
      Uri email = Uri(scheme: 'https', path: link);

      await u.launchUrl(email);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width - 110,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).colorScheme.secondary,
          ],
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: MediaQuery.of(context).size.height / 4,
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(.3),
                BlendMode.modulate,
              ),
              child: Image.asset("assets/images/logo.png"),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 100,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(
                      color: Colors.white,
                      width: 4,
                    )),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  maxRadius: 50,
                  backgroundImage:
                      NetworkImage(UserRepository.user?.profileImg as String),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                UserRepository.user?.name as String,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {},
                child: MenuItems(
                  menu: "About",
                ),
              ),
              MenuItems(
                menu: "Privacy Policy",
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    Preferences.routeName,
                  );
                },
                child: MenuItems(
                  menu: "Preferences",
                ),
              ),
              InkWell(
                child: MenuItems(
                  menu: "GitHub Repo",
                ),
                onTap: () =>
                    launchBrowser("www.github.com/BluFin-Designs/Invox-App"),
              ),
              InkWell(
                child: MenuItems(
                  menu: "Licenses",
                ),
                onTap: () => launchBrowser(
                    "www.github.com/BluFin-Designs/Invox-App/blob/main/LICENSE.md"),
              ),
              const Expanded(
                child: SizedBox(),
              ),
              Column(
                children: [
                  const Text(
                    "Designed & Developed by",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Image.asset("assets/images/blufin_logo.png"),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Divider(
                      color: Colors.white,
                      thickness: 2,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Version 1.0.0",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

class MenuItems extends StatelessWidget {
  String menu;
  MenuItems({
    Key? key,
    required this.menu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          menu,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Divider(
            color: Colors.white.withOpacity(.3),
            thickness: 1,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
