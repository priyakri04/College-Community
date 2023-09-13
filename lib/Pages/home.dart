import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:userauth/functions/auth.dart';
import 'package:userauth/login.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalKey<SliderDrawerState> _key = GlobalKey<SliderDrawerState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        //homepage of the
        body: 
        //wants the size same as appbar
        

        SliderDrawer(
          
          key: _key,
          appBar: const SliderAppBar(
            appBarColor: Colors.blueGrey,
            title: Text(
              'Home Page',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          slider: Container(color: Colors.blueGrey,), child: Container(color: Colors.white,)),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            FireAuth.signOut();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: const Icon(Icons.logout),
          backgroundColor: Colors.blueGrey,
        ));
  }
}
