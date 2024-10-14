import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Future<void> getTokenn()async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('jwt');
    setState(() {
      token = tok;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokenn();
  }


   String? token;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home"),),
      body: Center(
        child: Column(
          children: [
            Text(token.toString(),maxLines: 2,)
          ],
        ),
      ),
    );
  }
}