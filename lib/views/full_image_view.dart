import 'package:flutter/material.dart';
import '../models/image_model.dart';

class FullImageView extends StatelessWidget {
  final ImageModel image;
  const FullImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery X'),
      ),
      body: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Hero(
            tag: image.id,
            child: Image.network(image.imageUrl, fit: BoxFit.contain),
          ),
        ),
      ),
    );
  }
}
