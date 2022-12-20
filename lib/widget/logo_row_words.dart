import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoRowWords extends StatelessWidget {
  const LogoRowWords({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("polar",
            style: GoogleFonts.contrailOne(
              textStyle: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            )),
        Text(
          "OPs",
          style: GoogleFonts.audiowide(
            textStyle: const TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
        )
      ],
    );
  }
}
