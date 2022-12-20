import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:polar_ops/main.dart';
import 'package:polar_ops/widget/logo_row_words.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Text(""),
        centerTitle: false,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Icon(
              Icons.sledding,
              size: 44,
              color: Color.fromARGB(255, 18, 76, 123),
            ),
          ),
        ],
        backgroundColor: Colors.white54,
        title: const LogoRowWords(),
      ),
      body: Center(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: Platform.isIOS
                      ? MediaQuery.of(context).size.height * 0.72
                      : MediaQuery.of(context).size.height * 0.80,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Color.fromARGB(255, 197, 41, 30),
                        Colors.white,
                        Color.fromARGB(255, 19, 113, 22),
                      ],
                    ),
                  ),
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(
                        "https://static.wikia.nocookie.net/prepandlanding/images/2/24/Thrasher.png/revision/latest?cb=20200708105259",
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text("Naughty\nor\nNice?",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.ptMono(
                          textStyle: const TextStyle(
                            fontSize: 55,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        )),
                  ],

                  // FIXED IT UP A BIT WITH FONTS AND FORMATTING
                  // ALSO ADDED DATA MODEL AND DEMO DATA
                ),
              ],
            ),
            const SizedBox(height: 56)
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          isExtended: true,
          backgroundColor: Colors.red,
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (c) => MainPage()));
          },
          child: const Icon(
            Icons.home,
            size: 28,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
