import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/const/colors.dart';
import 'package:flutter_music_player/core/const/textstyles.dart';

AppBar customAppBar() {
  return AppBar(
    backgroundColor: bgDarkColor,
    centerTitle: true,
    actions: [
      IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.search,
          color: whiteColor,
        ),
      )
    ],
    leading: const Icon(
      Icons.sort_rounded,
      color: whiteColor,
    ),
    title: Text(
      'Music player',
      style: customTextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
