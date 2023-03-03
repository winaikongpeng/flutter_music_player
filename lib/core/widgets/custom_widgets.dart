import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/const/colors.dart';
import 'package:flutter_music_player/core/const/textstyles.dart';

Widget setIcon(bool isActive) {
  if (isActive) {
    return const Icon(
      Icons.pause,
      color: whiteColor,
      size: 26,
    );
  } else {
    return const Icon(
      Icons.play_arrow,
      color: whiteColor,
      size: 26,
    );
  }
}

Widget setLeading(String path) {
  AssetImage assetImage = AssetImage(path);
  return Image(
    image: assetImage,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(
        Icons.music_note,
        color: whiteColor,
        size: 32,
      );
    },
  );
}

Widget setSubtitle(String text) => Text(
      text,
      style: customTextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    );

Widget setTitle(String text) => Text(
      text,
      style: customTextStyle(fontSize: 15, fontWeight: FontWeight.bold),
    );

Widget loadingWidget() {
  return const Center(
    child: CircularProgressIndicator(
      color: Colors.grey,
      strokeWidth: 5,
    ),
  );
}

Widget errorText(String msg) => Center(
      child: Text(
        msg,
        style: customTextStyle(
          fontSize: 20,
          color: Colors.red,
          fontWeight: FontWeight.normal,
        ),
      ),
    );

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
