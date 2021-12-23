// import 'dart:js';

import 'package:flutter/material.dart';
import 'package:naamkaran/pages/boys.dart';
import 'package:naamkaran/pages/favpage.dart';
import 'package:naamkaran/pages/girl.dart';

class BoysandGirls extends StatefulWidget {
  const BoysandGirls({Key? key}) : super(key: key);

  @override
  _BoysandGirlsState createState() => _BoysandGirlsState();
}

class _BoysandGirlsState extends State<BoysandGirls> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.blue[800],
            child: Image.asset(
              "images/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                  width: 350,
                  height: 150,
                  // color: Colors.black,
                  child: Image.asset("images/naamkaranlogo.png")),
              // SizedBox(
              //   height: 100,
              // ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GirlsList()));
                        },
                        child: Image.asset(
                          "images/g.png",
                          // height: 350,
                          // width: 50,
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(100), // <-- Radius
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      height: 170,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BoysList()));
                        },
                        child: Image.asset(
                          "images/b.png",
                          fit: BoxFit.cover,
                        ),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(100), // <-- Radius
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 200,
                height: 100,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FavList()));
                  },
                  child: Image.asset("images/fav.png"),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.transparent,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100), // <-- Radius
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
