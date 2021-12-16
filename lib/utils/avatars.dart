import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final int? imageId;

  const Avatar({Key? key, this.imageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${imageId}.png',
        height: 200,
        width: 200,
      ),
    );
  }
}
