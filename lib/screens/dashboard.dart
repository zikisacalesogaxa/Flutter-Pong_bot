import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pong_bot/utils/avatars.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({Key? key}) : super(key: key);

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: Colors.red.withOpacity(0.5),
          ),
          child: Text(
            user?.email![0].toUpperCase() ?? 'Pong Bot',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        toolbarHeight: 80.0,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            color: Colors.red,
            iconSize: 30.0,
            onPressed: () => {
              FirebaseAuth.instance.signOut(),
              Navigator.of(context).pushReplacementNamed('/login')
            },
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildProfileInfo(user?.email),
        ],
      ),
    );
  }

  Widget _buildProfileInfo(String? email) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('players')
          .where('email', isEqualTo: email)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator.adaptive();
        }

        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildAvatar(context, snapshot.data?.docs.first.data()),
              _buildStats(context, snapshot.data?.docs.first.data()),
              const SizedBox(height: 20),
              _buildText(context, 'Leaderboard', 24.0, FontWeight.w700),
              const SizedBox(height: 40),
              _buildAllPlayers(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildAllPlayers(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('players')
          .orderBy('avg', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator.adaptive();
        }

        return Expanded(
          child: ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              final player = snapshot.data?.docs[index].data();
              return ListTile(
                title: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.red.withOpacity(0.5),
                  ),
                  child: _buildPlayer(context, player),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildPlayer(BuildContext context, player) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Avatar(
                imageId: player['imageId'],
                height: 50.0,
                width: 50.0,
              ),
              const SizedBox(
                width: 10,
              ),
              _buildText(context, player['email'][0].toUpperCase() ?? '', 20.0,
                  FontWeight.w900),
            ],
          ),
          Row(
            children: [
              _buildText(context, 'W: ${player['wins'].toString()}', 16.0,
                  FontWeight.bold),
              const SizedBox(width: 2),
              _buildText(context, '|', 20, FontWeight.w900),
              const SizedBox(width: 2),
              _buildText(context, 'L: ${player['losses'].toString()}', 16.0,
                  FontWeight.bold),
              const SizedBox(width: 2),
              _buildText(context, '|', 20, FontWeight.w900),
              const SizedBox(width: 2),
              _buildText(context, 'GP: ${player['gamesPlayed'].toString()}',
                  16.0, FontWeight.bold),
              const SizedBox(width: 2),
              _buildText(context, '|', 20, FontWeight.w900),
              const SizedBox(width: 2),
              _buildText(context, 'R: ${player['avg'].toString()}', 16.0,
                  FontWeight.bold)
            ],
          )
        ],
      ),
    );
  }

  Widget _buildAvatar(BuildContext context, snapshot) {
    return Avatar(
      imageId: snapshot['imageId'],
    );
  }

  Widget _buildStats(BuildContext context, snapshot) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.blue.withOpacity(0.8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildText(context, 'W: ${snapshot['wins']}', 24.0, FontWeight.w400),
          _buildText(
              context, 'L: ${snapshot['losses']}', 24.0, FontWeight.w400),
          _buildText(
              context, 'GP: ${snapshot['gamesPlayed']}', 24.0, FontWeight.w400),
          _buildText(context, 'R: ${snapshot['avg']}', 24.0, FontWeight.w400),
        ],
      ),
    );
  }

  Widget _buildText(
      BuildContext context, String? text, double? size, FontWeight? weight) {
    return Text(
      text!,
      style: TextStyle(
        fontSize: size ?? 24.0,
        fontWeight: weight ?? FontWeight.w600,
      ),
    );
  }
}
