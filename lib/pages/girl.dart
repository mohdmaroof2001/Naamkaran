// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:convert';
// import 'dart:js';
// import 'dart:js';
// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:naamkaran/modal/allnames.dart';
import 'package:naamkaran/modal/categoryname.dart';
import 'package:naamkaran/pages/boys.dart';
import 'package:clipboard/clipboard.dart';
import 'package:naamkaran/pages/favpage.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GirlsList extends StatefulWidget {
  const GirlsList({Key? key}) : super(key: key);

  @override
  _GirlsState createState() => _GirlsState();
}

class _GirlsState extends State<GirlsList> with SingleTickerProviderStateMixin {
  late TabController _controller;

  List<CategoryDemo> catArr = [];
  List<NamesDemo> namesArr = [];
  List<NamesDemo> users = [];
  var Clicked = -1;
  var dataLoaded = false;

  @override
  void initState() {
    super.initState();
    categoryCall();
    _controller = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          if (_controller.index == 0) {
            nameList(3, 2);
          } else if (_controller.index == 1) {
            nameList(8, 2);
          } else if (_controller.index == 2) {
            nameList(10, 2);
          }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/girl_background.png",
              fit: BoxFit.cover,
            ),
          ),
          DefaultTabController(
            length: 3,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: myappBar(context),
              body: namesArr.isEmpty
                  ? Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        backgroundColor: Colors.white,
                        color: Colors.pink,
                      ),
                    )
                  : TabBarView(
                      controller: _controller,
                      children: [
                        nameShow(),
                        nameShow(),
                        nameShow(),
                      ],
                    ),
            ),
            // }),
          ),
        ],
      ),
    );
  }

// AppBar Method
  AppBar myappBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Image.asset(
        "images/logo.png",
        width: 120,
        height: 80,
        // fit: BoxFit.cover,
      ),
      actions: [
        Image.asset(
          "images/girl.png",
          width: 60,
          height: 60,
        ),
        SizedBox(
          width: 15,
        ),
        IconButton(
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => FavList()));
            },
            icon: Icon(
              Icons.favorite_border_rounded,
              size: 30,
            )),
        IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchDemo(namesArr));
            },
            icon: Icon(
              Icons.search,
              size: 30,
            ))
      ],
      bottom: catArr.isEmpty
          ? PreferredSize(child: SizedBox(), preferredSize: Size(0, 0))
          : TabBar(
              controller: _controller,
              // onTap: (index) {
              //   if (index == 0) {
              //     // namesArr.clear();
              //     nameList(3, 2);

              //     print(" hindu");
              //   } else if (index == 1) {
              //     // namesArr.clear();
              //     nameList(8, 2);
              //   } else if (index == 2) {
              //     // namesArr.clear();
              //     nameList(10, 2);
              //   }
              //   {
              //     // nameList(8, 2);
              //   }
              // },

              tabs: catArr.map((e) {
                return Tab(
                    child: Text(e.catName.toString(),
                        style: TextStyle(fontSize: 18, color: Colors.black)));
              }).toList(),
              indicatorColor: Colors.white,
              indicatorWeight: 5,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), // Creates border
                  color: Colors.white),
            ),
    );
  }

// All Religion Category
  categoryCall() async {
    var recp = await http.get(
      Uri.parse('http://mapi.trycatchtech.com/v1/naamkaran/category_list'),
    );
    var jsonresp = jsonDecode(recp.body) as List;
    for (var item in jsonresp) {
      // print("item $item");
      setState(() {
        catArr.add(CategoryDemo.fromJson(item));
      });
    }
    nameList(3, 2);
  }

// Search TextField Ui

  // search() {
  //   return TextField(
  //     decoration: InputDecoration(
  //         focusedBorder: OutlineInputBorder(
  //           borderSide: new BorderSide(color: Colors.white),
  //           borderRadius: new BorderRadius.circular(25.7),
  //         ),
  //         enabledBorder: UnderlineInputBorder(
  //           borderSide: new BorderSide(color: Colors.white),
  //           borderRadius: new BorderRadius.circular(25.7),
  //         ),
  //         contentPadding: EdgeInsets.all(10),
  //         prefixIcon: Icon(Icons.search, color: Colors.grey),
  //         hintText: 'Search Name',
  //         filled: true,
  //         fillColor: Colors.white,
  //         border: OutlineInputBorder(
  //           borderSide: BorderSide(),
  //         )),
  //     onChanged: (String) {
  //       setState(() {
  //         users = namesArr
  //             .where((element) =>
  //                 (element.name!.toLowerCase().contains(String.toLowerCase())))
  //             .toList();
  //       });
  //     },
  //   );
  // }
// All Name Show in List Page

  // All Names Shoe in List Page
  nameShow() {
    bool isFav = true;
    // return SizedBox();
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Container(
        // color: Colors.black,
        child: ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, indexNo) {
              return Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.pink[50],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            namesArr[indexNo].name.toString(),
                            style: TextStyle(fontSize: 22, color: Colors.pink),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              namesArr[indexNo].meaning.toString(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              // softWrap: ,
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Clicked == indexNo
                          //     ? IconButton(
                          //         onPressed: () {
                          //           print("hello");
                          //         },
                          //         icon: Icon(Icons.favorite,
                          //             color: Colors.red))
                          //     :
                          IconButton(
                              onPressed: () async {
                                print("hello haa $indexNo");
                                List<String> temp = [];

                                temp.add(
                                    "${namesArr[indexNo].name.toString()}\n${namesArr[indexNo].meaning.toString()}");
                                // temp = [
                                //   "${namesArr[indexNo].name.toString()}"
                                // ];
                                SharedPreferences preferences =
                                    await SharedPreferences.getInstance();
                                preferences.setStringList("FavData", temp);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("Add to Favorite")));
                              },
                              icon: isFav
                                  ? const Icon(
                                      Icons.favorite_outline_rounded,
                                      color: Colors.pink,
                                    )
                                  : const Icon(
                                      Icons.favorite_rounded,
                                      color: Colors.pink,
                                    )),
                          IconButton(
                              onPressed: () async {
                                await FlutterClipboard.copy(
                                    namesArr[indexNo].name.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text("Copy to Clipboard")));
                              },
                              icon: Icon(
                                Icons.copy,
                                color: Colors.pink,
                              )),
                          IconButton(
                              onPressed: () {
                                Share.share(
                                    "Name: ${namesArr[indexNo].name.toString()}\nMeaning: ${namesArr[indexNo].meaning.toString()}");
                              },
                              icon: Icon(
                                Icons.share,
                                color: Colors.pink,
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, indexNo) {
              return Divider(
                height: 5,
              );
            },
            itemCount: namesArr.length),
      ),
    );
  }

// All Names Api Call Method
  nameList(int catId, int genderId) async {
    namesArr.clear();
    var recp = await http.get(
      Uri.parse(
          'https://mapi.trycatchtech.com/v1/naamkaran/post_list_by_cat_and_gender?category_id=$catId&gender=$genderId'),
    );
    var jsonresp = jsonDecode(recp.body) as List;
    for (var item in jsonresp) {
      // print("item $item");
      setState(() {
        namesArr.add(NamesDemo.fromJson(item));
        dataLoaded = true;
      });
    }
    // nameShow();
  }
}

// Search Field
class SearchDemo extends SearchDelegate {
  List<NamesDemo> SearchName;
  SearchDemo(this.SearchName);
  @override
  List<Widget>? buildActions(BuildContext context) {
    // throw UnimplementedError();
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close_rounded)),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // throw UnimplementedError();
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back_rounded));
  }

  @override
  Widget buildResults(BuildContext context) {
    // throw UnimplementedError();
    List<NamesDemo> searchQuery = [];
    for (var item in SearchName) {
      if (item.name!.toLowerCase().contains(query.toLowerCase())) {
        searchQuery.add(item);
      }
    }
    return Stack(
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
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: ListView.builder(
              itemCount: searchQuery.length,
              itemBuilder: (context, indexNo) {
                return Column(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.orange[50],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: ListTile(
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              searchQuery[indexNo].name.toString(),
                              style:
                                  TextStyle(fontSize: 22, color: Colors.pink),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              width: 200,
                              child: Text(
                                searchQuery[indexNo].meaning.toString(),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                // softWrap: ,
                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    )
                  ],
                );
              }),
        ),
      ],
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // throw UnimplementedError();
    List<NamesDemo> searchQuery = [];
    for (var item in SearchName) {
      if (item.name!.toLowerCase().contains(query.toLowerCase())) {
        searchQuery.add(item);
      }
    }
    if (searchQuery.isEmpty) {
      return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/home.png",
              fit: BoxFit.cover,
            ),
          ),
          const Center(
            child: Text(
              "No Data Found",
              style: TextStyle(
                  fontSize: 25,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
    } else {
      return Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Image.asset(
              "images/home.png",
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: ListView.builder(
                itemCount: searchQuery.length,
                itemBuilder: (context, indexNo) {
                  return Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.orange[50],
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                searchQuery[indexNo].name.toString(),
                                style:
                                    TextStyle(fontSize: 22, color: Colors.pink),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: 200,
                                child: Text(
                                  searchQuery[indexNo].meaning.toString(),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  // softWrap: ,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      )
                    ],
                  );
                }),
          ),
        ],
      );
    }
  }
}
