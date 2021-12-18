import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final int? imageId;
  final double? height;
  final double? width;

  const Avatar({Key? key, this.imageId, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/${imageId}.png',
      height: height ?? 100,
      width: width ?? 100,
    );
  }
}
