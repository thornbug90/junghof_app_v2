import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:junghof_app_v2/login_screen.dart';
import 'package:junghof_app_v2/tickets.dart';

void checkEmailToGetUser() {
  User? user = auth.currentUser;
  if (user?.email == 'cakeclicker@gmx.de') {
    user?.updateDisplayName('CakeClicker');
  }
}

//rework someday right now idfc
bool loginUser() {
 
auth.signInWithEmailAndPassword(
        email: controllerinputemail.text.toString(),
        password: controllerinputpassword.text.toString());

if (auth.currentUser != null) {
  return true;
} else {
  return false;
}
}


Widget buildTickets(List<Ticket> tickets) => ListView.builder(
    itemCount: tickets.length,
    itemBuilder: (context, index) {
      final ticket = tickets[index];

      return Card(
        child: ListTile(
          leading: const CircleAvatar(
            radius: 28,
          ),
          title: Text(ticket.name),
          subtitle: Text(ticket.subject),
          onTap: () {
            showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(ticket.subject),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(ticket.name),
                    Text(ticket.email),
                    Text(ticket.message),
                  ],
                ),
                actions: [
                  FloatingActionButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0))),
                ],
              );
            });
          },
        ),
      );
    });

bool isOwner() {
  if (auth.currentUser?.displayName == 'CakeClicker')
    return true;
  else
    return false;
}
