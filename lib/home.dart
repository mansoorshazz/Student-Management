// ignore_for_file: unused_local_variable, prefer_const_constructors

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:week_5/details.dart';
import 'package:week_5/details.dart';
import 'package:week_5/fulldetails.dart';
import 'package:week_5/model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

late Uint8List imageBytes;
String _searchText = "";
dynamic ind;

Icon actionIcon = Icon(
  Icons.search,
  color: Colors.white,
);
Widget appBarTitle =
    Text("Student Records", style: GoogleFonts.lancelot(fontSize: 30));

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.black, Colors.blueGrey, Colors.black])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildBar(context),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: ElevatedButton.icon(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(Colors.blueGrey.shade500)),
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddDetails()));
            },
            icon: Icon(Icons.add),
            label: Text('Add a student')),
        body: ValueListenableBuilder(
          valueListenable: Hive.box<Students>('records').listenable(),
          builder: (context, Box<Students> box, _) {
            var results = _searchText.isEmpty
                ? box.values.toList()
                : box.values
                    .where(
                      (c) => c.name.toLowerCase().contains(_searchText),
                    )
                    .toList();

            return results.isEmpty
                ? Center(
                    child: Text(
                      'No Records Available !',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          if (results[index].pic != null) {
                            imageBytes = base64Decode(results[index].pic);
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 13.0, right: 13, top: 13),
                              child: Container(
                                height: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(7))),
                                child: Container(
                                  child: ListTile(
                                    title: Text(results[index].name,
                                        style: GoogleFonts.actor(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400,
                                        )),
                                    leading: Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Container(
                                        clipBehavior: Clip.hardEdge,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.memory(
                                          imageBytes,
                                          height: 50,
                                          width: 50,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => FullDetails(
                                                    name: results[index].name,
                                                    age: results[index].age,
                                                    place: results[index].place,
                                                    pic: results[index].pic,
                                                    index: index,
                                                    box: box,
                                                  )));
                                    },
                                  ),
                                ),
                              ),
                            );
                          }

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 13.0, right: 13, top: 13),
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7))),
                              child: Container(
                                child: ListTile(
                                  leading: Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: CircleAvatar(
                                        radius: 25,
                                        backgroundImage: AssetImage(
                                            'assets/images/student-icon.png')),
                                  ),
                                  title: Text(results[index].name,
                                      style: GoogleFonts.actor(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400,
                                      )),
                                  onTap: () {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (context) => FullDetails(
                                                  name: results[index].name,
                                                  age: results[index].age,
                                                  place: results[index].place,
                                                  pic: results[index].pic,
                                                  index: index,
                                                  box: box,
                                                )));
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                  );
          },
        ),
      ),
    );
  }

  buildBar(BuildContext context) {
    return AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: appBarTitle,
        actions: <Widget>[
          IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (actionIcon.icon == Icons.search) {
                  // ignore: prefer__ructors
                  actionIcon = const Icon(
                    Icons.close,
                    color: Colors.white,
                  );

                  appBarTitle = TextField(
                    cursorHeight: 20,
                    onChanged: (value) {
                      setState(() {
                        _searchText = value;
                      });
                    },
                    cursorColor: Colors.white,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: Colors.white),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.white),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                  );
                } else if (actionIcon.icon == Icons.close) {
                  appBarTitle = Text(
                    'Students Records',
                    style: GoogleFonts.lancelot(fontSize: 25),
                  );
                  actionIcon = const Icon(
                    Icons.search,
                  );
                }
              });
            },
          ),
        ]);
  }
}
