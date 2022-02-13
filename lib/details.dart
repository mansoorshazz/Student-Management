// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
// import 'dart:html';
// import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:week_5/model.dart';
import 'package:image_picker/image_picker.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({Key? key}) : super(key: key);

  @override
  _AddDetailsState createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  final formkey = GlobalKey<FormState>();

  late String name, age, place;
  dynamic pic;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 4,
                  ),
                  ProfileImage(pic),

                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a name';
                        } else if (value.trim().isEmpty) {
                          return 'please enter a name';
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  //  ----------------------------------------------------
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          age = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a Age';
                        } else if (value.trim().isEmpty) {
                          return 'please enter a age';
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Age',
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  // buildTextFormField(validateText[1], hintText[1], age,
                  //     keyboardNumber: number),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          place = value.trim();
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter a place';
                        } else if (value.trim().isEmpty) {
                          return 'please enter a place';
                        }
                      },
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Place',
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(),
                      ),
                    ),
                  ),

                  // buildTextFormField(validateText[2], hintText[2], place),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(
                        height: 60,
                      ),
                      ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  Colors.red.shade800)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('CANCEL')),
                      const SizedBox(
                        width: 10,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            Navigator.of(context).pop();
                            final std = Hive.box<Students>('records');
                            std.add(Students(name, age, place, pic));
                          }
                        },
                        child: const Text('SAVE'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade800)),
                      ),
                      const SizedBox(
                        width: 18,
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addStudent() {
    if (formkey.currentState!.validate()) {
      Box<Students> studentDb = Hive.box<Students>('records');

      studentDb.add(Students(name, age, place, pic));

      Navigator.of(context).pop();
    }
  }

  // -----------------------------------------------------------------------------------------------

  File? image;
  dynamic path;
  pickImage(source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      Uint8List imageBytes = await image.readAsBytes();
      pic = base64Encode(imageBytes);
    }
    setState(
      () {
        if (image != null) {
          path = image.path;
        }
      },
    );
  }

// -------------------------------------------------------------------------------------------------------------------

  Widget ProfileImage(pic) {
    if (pic != null) {
      Uint8List imageBytes = base64Decode(pic);
      return ClipOval(
        child: GestureDetector(
          onTap: () => pickImage(ImageSource.gallery),
          child: Image.memory(
            imageBytes,
            height: 150,
            width: 150,
            fit: BoxFit.cover,
          ),
        ),
      );
    }
    return GestureDetector(
      onDoubleTap: () => pickImage(ImageSource.camera),
      child: CircleAvatar(
        backgroundImage: AssetImage(
          "assets/images/image_upload_placeholder.jpg",
        ),
        backgroundColor: Colors.amber,
        radius: 70,
      ),
      onTap: () => pickImage(ImageSource.gallery),
    );
  }
}
