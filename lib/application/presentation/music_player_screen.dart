import 'package:flutter/material.dart';
import 'package:flutter_music_player/core/const/colors.dart';
import 'package:flutter_music_player/core/const/textstyles.dart';

class MusicPlayerScreen extends StatelessWidget {
  const MusicPlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (ctx, index) {
          String musicName = 'musicName';
          String artistName = 'artistName';

          return Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              tileColor: bgColor,
              title: Text(
                musicName,
                style:
                    customTextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                artistName,
                style: customTextStyle(
                    fontSize: 12, fontWeight: FontWeight.normal),
              ),
              leading: const Icon(
                Icons.music_note,
                color: whiteColor,
                size: 32,
              ),
              trailing: const Icon(
                Icons.play_arrow,
                color: whiteColor,
                size: 26,
              ),
            ),
          );
        },
      ),
    );
  }
}
