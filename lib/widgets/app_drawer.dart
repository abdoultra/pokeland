// /widgets/app_drawer.dart
import 'package:flutter/material.dart';
import 'package:pokeland/views/search_page.dart';
import 'package:pokeland/views/explore_page.dart';
import 'package:pokeland/views/detail_page.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Accueil'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
          ListTile(
            leading: Icon(Icons.search),
            title: Text('rechercher'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SearchPage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.explore),
            title: Text('explorer'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ExplorePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('détails'),
            onTap: () {
              Navigator.pop(context); // Ferme le drawer
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
