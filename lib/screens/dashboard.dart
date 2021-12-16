import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pong_bot/widgets/button.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            user?.email ?? '',
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
              color: Colors.black,
            ),
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Button(
      text: 'Log out',
      textColor: Colors.white,
      onPressed: () async {
        await FirebaseAuth.instance.signOut();
        Navigator.pushNamed(context, "/login");
      },
    );
  }
}
