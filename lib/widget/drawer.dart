import 'package:flutter/material.dart';
import 'package:weather_api_indonesia/pages/login.dart';

Color _firstColor = const Color(0xffe84a5f);
Color _secondColor = const Color(0xff3d405b);

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = const EdgeInsets.symmetric(horizontal: 20);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.all(15),
        color: _secondColor,
        child: ListView(
          children: <Widget>[
            buildHeader(),
            const SizedBox(height: 35),
            buildMenuItem(
              text: 'Friends',
              icon: Icons.people_alt_rounded,
              onClicked: () {},
            ),
            buildMenuItem(
              text: 'Notification',
              icon: Icons.notifications,
              onClicked: () {},
            ),
            buildMenuItem(
              text: 'Wishlist',
              icon: Icons.favorite,
              onClicked: () {},
            ),
            buildMenuItem(
              text: 'Bookmark',
              icon: Icons.bookmark,
              onClicked: () {},
            ),
            buildMenuItem(
              text: 'History',
              icon: Icons.history,
              onClicked: () {},
            ),
            const SizedBox(height: 24),
            const Divider(color: Colors.white70),
            const SizedBox(height: 24),
            buildMenuItem(
              text: 'Settings',
              icon: Icons.settings,
              onClicked: () {},
            ),
            buildMenuItem(
              text: 'Logout',
              icon: Icons.logout,
              onClicked: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  Color color = _firstColor;

  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: TextStyle(
        color: _firstColor,
      ),
    ),
    hoverColor: _firstColor,
    onTap: onClicked,
  );
}

Widget buildHeader() => InkWell(
      child: Container(
        // color: const Color.fromRGBO(255, 163, 26, 1),
        padding: const EdgeInsets.only(
          top: 10,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                'images/user.JPG',
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Daniel Febrian E.W.',
              style: TextStyle(
                  color: _firstColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'danielfebrian61@gmail.com',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
