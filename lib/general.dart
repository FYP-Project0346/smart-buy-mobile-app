import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'constants.dart';

class General{
  static Widget showProductImage(String url, {
    double? height,
    double? width,
  }){
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      child: CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: url,
        fit: BoxFit.cover,
        placeholder: (_, __) => const Center(child: CupertinoActivityIndicator()),
        errorWidget: (_, __, ___) => Image.asset(ProjectPaths.productPlaceholderImage),
      ),
    );
  }


  static List<Widget> getRatingStar(int rating,
  {
    double size = 18,
    Color? filledStarColor,
    Color? borderStarColor,
  }){
    // log("Rating: ${rating.toString()}");
    filledStarColor ??= const Color.fromRGBO(255, 215, 0, 1);
    List<Widget> stars = [];
    for (int i=1; i<=5; i++){
      if (rating != 0){
        stars.add(Icon(Icons.star, size: size, color: filledStarColor, ));
        rating--;
      }else{
        stars.add(Icon(Icons.star_border, size:size, color: borderStarColor));
      }
    }
    return stars;
  }
}