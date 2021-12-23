// import 'dart:html';

// import 'dart:js';

// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavList extends StatefulWidget {
  const FavList({Key? key}) : super(key: key);

  @override
  _FavListState createState() => _FavListState();
}

class _FavListState extends State<FavList> {
  List<String> data = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text("My Favorites"),
        backgroundColor: Colors.orange[800],
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/home.png",
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
                child: ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, indexNo) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 300,
                                child: Text(
                                  data[indexNo],
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: ,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    print("Work");
                                    deletfavname(indexNo);
                                  },
                                  icon: Icon(
                                    Icons.highlight_remove,
                                    color: Colors.red,
                                  ))
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, indexNO) {
                      return Divider(
                        height: 8,
                      );
                    },
                    itemCount: data.length)),
          ),
        ],
      ),
    );
  }

  getdata() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      data = preferences.getStringList("FavData")!;
      print(data);
    });
    // print("Data hai ye ${data}");
  }

  deletfavname(int IndexNo) async {
    var temp = [];
    temp = data;
    temp.removeAt(IndexNo);
    setState(() {
      // data = temp[IndexNo];
    });
    // AddCityname();
    getdata();
  }
}
