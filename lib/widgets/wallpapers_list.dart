import 'package:flutter/material.dart';
import 'package:pexelsHub/models/wallpaper.dart';

Widget wallpapersList({List<Wallpaper> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper) {
        return GridTile(
          child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                wallpaper.source.portrait,
                fit: BoxFit.cover,
              ),
            )
          ),
        );
      }).toList(),
    ),
  );
}