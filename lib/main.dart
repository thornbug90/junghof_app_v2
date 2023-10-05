import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:junghof_app_v2/tickets.dart';
import 'package:junghof_app_v2/user_functions.dart';
import 'navbar.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:junghof_app_v2/login_screen.dart';

import 'package:http/http.dart' as http;

List<Ticket> myList = [];
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Junghof e.V.',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 212, 72, 62)),
        useMaterial3: true,
      ),
      //Enter LoginScreen
      home: const LoginDemo(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

//Maybe remove?
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Ticket>> ticketFuture = getTickets();

  static Future<List<Ticket>> getTickets() async {
    // const url =
    //     'https://raw.githubusercontent.com/CakeClicker/AppPictures/main/myJsonFile0.json';
    const url =
        'https://raw.githubusercontent.com/CakeClicker/AppPictures/main/test.json';

    final response = await http.get(Uri.parse(url));

    final body = json.decode(response.body);
    return body.map<Ticket>(Ticket.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavBar(),
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: RefreshIndicator(
        //doesnt work but doesnt break anthing win-win
        onRefresh: () async {
          getTickets();
          buildTickets(myList);
        },
        child: FutureBuilder<List<Ticket>>(
          future: ticketFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}}');
            } else if (snapshot.hasData) {
              final tickets = snapshot.data!;
              myList = tickets;
              return buildTickets(tickets);
            } else {
              return const Text('Keine Daten');
            }
          },
        ),
      ),
    );
  }
}
