import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class loadingscreen extends StatefulWidget {
  const loadingscreen({Key? key}) : super(key: key);

  @override
  _loadingscreenState createState() => _loadingscreenState();
}

class _loadingscreenState extends State<loadingscreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFE5E5E5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(

            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                    children: [
                  Image.asset('images/ellipse.png',
                  color: Color(0xFFFF6E30),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Loading....",
                    style: GoogleFonts.openSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black
                    ),
                    ),
                    SizedBox(
                      height: 2,
                    ),
                    Text("Just a moment",
                      style: GoogleFonts.openSans(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black
                      ),)
                  ],
                ),

                ]
          ),
              ],
            ),
          ),
        ],
      )
    );
  }
}
