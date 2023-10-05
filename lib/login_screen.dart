import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junghof_app_v2/main.dart';
import 'package:junghof_app_v2/navbar.dart';
import 'package:junghof_app_v2/user_functions.dart';

// import 'package:firebase_database/firebase_database.dart';

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  State<LoginDemo> createState() => _LoginDemoState();
}

// FirebaseDatabase database = FirebaseDatabase.instance;

// DatabaseReference ref = FirebaseDatabase.instance.ref();

// Create Auth Instance
FirebaseAuth auth = FirebaseAuth.instance;

String name = '';
String email = '';
String password = '';

String navbar_pfp = '';

/*Controller for Email and Password field to pass the value to
the firebase auth service*/
final controllerinputemail = TextEditingController();
final controllerinputpassword = TextEditingController();

class _LoginDemoState extends State<LoginDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Bitte logge dich ein"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 60.0),
              child: Center(
                  child: SizedBox(
                width: 200,
                height: 150,
                /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
              )),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerinputemail,
                autofocus: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Als Beispiel abc@gmail.com'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: controllerinputpassword,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Passwort',
                    hintText: 'Super geheimes Passwort'),
              ),
            ),
            // FlatButton(
            //   onPressed: (){
            //     //TODO FORGOT PASSWORD SCREEN GOES HERE
            //   },
            //   child: Text(
            //     'Forgot Password',
            //     style: TextStyle(color: Colors.blue, fontSize: 15),
            //   ),
            // ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: FloatingActionButton(
                onPressed: () async {
                  bool islogin = await loginUser();
                  if (!islogin) {
                  } else {
                    // todo: rework doesnt work
                    checkEmailToGetUser(); //this will detect and setup the correct displayname

                    //this will load the users pfp. currently a placeholder and i should add it to a function later im lazzy rn lol
                    navbar_pfp =
                        'https://raw.githubusercontent.com/CakeClicker/AppPictures/main/output-onlinepngtools%20(2).png';

                    FirebaseAuth.instance
                        .authStateChanges()
                        .listen((User? user) {
                      if (user != null) {
                        print(user.uid);
                        accountNames = user.displayName.toString();
                        accountEmail = user.email.toString();
                      }
                    });
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            const MyHomePage(title: 'Junghof e.v.')));
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
          ],
        ),
      ),
    );
  }
}
