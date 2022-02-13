import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';

import 'package:week_5/home.dart';
import 'package:week_5/model.dart';
import 'package:week_5/update.dart';

class FullDetails extends StatefulWidget {
  var name, age, index, box, place;
  dynamic pic;
  FullDetails(
      {Key? key,
      required this.name,
      required this.age,
      required this.place,
      required this.index,
      required this.box,
      this.pic})
      : super(key: key);

  @override
  _FullDetailsState createState() => _FullDetailsState();
}

class _FullDetailsState extends State<FullDetails> {
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
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.black, Colors.blueGrey, Colors.black])),
          ),
          title: Text(
            'Student Details',
            style: GoogleFonts.headlandOne(fontSize: 22),
          ),
          centerTitle: true,
        ),
        floatingActionButton: SpeedDial(
          backgroundColor: Colors.white,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(color: Colors.black),
          overlayColor: Colors.black,
          overlayOpacity: 0.4,
          spaceBetweenChildren: 10,
          spacing: 5,
          children: [
            SpeedDialChild(
                child: Icon(Icons.edit),
                label: 'Edit',
                onTap: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Update(
                            name2: widget.name,
                            age2: widget.age,
                            place2: widget.place,
                            index2: widget.index,
                            box2: widget.box,
                          )));
                }),
            SpeedDialChild(
                child: Icon(Icons.delete),
                onTap: () {
                  final delete = Hive.box<Students>('records');
                  delete.deleteAt(widget.index);
                  Navigator.of(context).pop();
                },
                label: 'Delete')
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            showProfile(widget.pic),
            SizedBox(
              height: 10,
            ),
            buildContainerText(widget.name, 'Name'),
            buildContainerText(widget.age, 'Age'),
            buildContainerText(widget.place, 'Place')
            // buildContainerText(widget.place, 'Place')
          ],
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget buildContainerText(dbText, NormalText) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15, top: 15),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 15),
          child: Text(
            '$NormalText :  $dbText',
            style: GoogleFonts.aleo(fontSize: 22),
          ),
        ),
      ),
    );
  }
}

Widget showProfile(dynamic pic) {
  if (pic != null) {
    // Uint8List imageBytes = base64Decode(pic);
    Uint8List imageBytes = base64Decode(pic);
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Image.memory(
        imageBytes,
        height: 150,
        width: 150,
        fit: BoxFit.cover,
      ),
    );
  }
  return Container(
    clipBehavior: Clip.hardEdge,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
    ),
    child: Image.asset(
      "assets/images/student-icon.png",
      height: 200,
      width: 200,
    ),
  );
}
