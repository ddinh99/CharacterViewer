// By: Dai Dinh
// 8/4/2023

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ImageWithPlaceholder extends StatelessWidget {
  final String imageUrl;

  ImageWithPlaceholder({required this.imageUrl});

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double size = (screenWidth<screenHeight)?200:100;
    return CachedNetworkImage(
      imageUrl: imageUrl,
      placeholder: (context, url) => PlaceholderWidget(), // Show placeholder while loading
      errorWidget: (context, url, error) => Icon(Icons.error,
      size:size, // Show an error icon if the image fails to load
    ));
  }
}

class PlaceholderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double size = (screenWidth<screenHeight)?200:100;
    return Icon(
      Icons.account_circle, // Use any silhouette icon you prefer
      size: size, // Set the size of the icon as per your preference
      color: Colors.grey, // Set the color of the icon as per your preference
    );
  }
}
