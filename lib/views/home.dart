import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pexelsHub/data/data.dart';
import 'package:pexelsHub/models/category.dart';
import 'package:pexelsHub/models/wallpaper.dart';
import 'package:pexelsHub/widgets/app_logo.dart';
import 'package:http/http.dart' as http;
import 'package:pexelsHub/widgets/wallpapers_list.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = new List();
  List<Wallpaper> wallpapers = new List();

  getCuratedWallpapers() async {
    var response = await http.get(
      'https://api.pexels.com/v1/curated?per_page=15&page=1',
      headers: {
        'Authorization': apiKey
      }
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    data['photos'].forEach((photo) {
      Wallpaper wallpaper = Wallpaper.fromMap(photo);
      wallpapers.add(wallpaper);
    });

    setState(() {});
  }

  @override
  void initState() {
    getCuratedWallpapers();
    categories = getCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: appLogo(),
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'search wallpapers',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Container(
                height: 80,
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: ListView.builder(
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      title: categories[index].name,
                      imageUrl: categories[index].imageUrl,
                    );
                  },
                ),
              ),
              SizedBox(height: 16),
              wallpapersList(
                wallpapers: wallpapers,
                context: context,
              ),
            ],
          ),
        ),
      )
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl;
  final String title;

  CategoryTile({
    @required
    this.imageUrl,
    @required
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 4),
      child: Stack(
        children: <Widget>[
          ClipRRect(
            child: Image.network(
              imageUrl,
              height: 50,
              width: 100,
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 50,
            width: 100,
            alignment: Alignment.center,
            child: Text(
              title, 
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
          )
        ],
      ),
    );
  }
}
