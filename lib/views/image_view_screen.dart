import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';

class ImageViewScreen extends StatelessWidget {
  const ImageViewScreen({Key? key, required this.imageUrl}) : super ();
  final String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: 
      Stack (children: [
        Image.network(imageUrl),
        BackButton(),
      ],)),
    );
  }
}