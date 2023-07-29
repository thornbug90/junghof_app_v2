import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junghof_app_v2/settings.dart';
import 'package:junghof_app_v2/login_screen.dart';
import 'package:junghof_app_v2/user_functions.dart';

String accountNames = 'displayName';
String accountEmail = 'Junghof.istcool@balou.woof';
String accountAnon = 'Anonym';
String idfc = 'displayName';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(accountNames.toString()),
            accountEmail: Text(accountEmail.toString()),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network( // Testing asset function to load pfp in the background
                  navbar_pfp.toString(),
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://raw.githubusercontent.com/CakeClicker/AppPictures/main/output-onlinepngtools%20(1).png')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Anfragen'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.calendar_today),
            title: const Text('Kalender'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.note),
            title: const Text('Notizen'),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LoginDemo()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Benachrichtigungen'),
            onTap: _authstatechange,
          ),
          const Divider(),
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Einstellungen'),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const SettingsPage()));
              }),
          const Divider(),
          ListTile(
              title: const Text('App verlassen'),
              leading: const Icon(Icons.exit_to_app),
              onTap: () => exit(1)),
          ListTile(
              title: const Text('(Dev) Debug'),
              leading: const Icon(Icons.developer_mode),
              enabled: isOwner(),
              onTap: () => exit(911)),
        ],
      ),
    );
  }

  void _authstatechange() {
    auth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in as ${user.displayName}');
      }
    });
  }
}
