// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
// import 'package:hive/hive.dart';

import 'package:week_5/fulldetails.dart';
import 'package:week_5/fulldetails.dart';
import 'package:week_5/home.dart';
import 'package:week_5/model.dart';
// import 'package:image_picker/image_picker.dart';

class Update extends StatefulWidget {
  late var name2, age2, index2, box2, place2;
  // dynamic pic;
  Update({
    Key? key,
    required this.name2,
    required this.age2,
    required this.index2,
    required this.place2,
    required this.box2,
  }) : super(key: key);

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  final formkey = GlobalKey<FormState>();
  // late String name, age;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          // ProfileImage(widget.pic),
          Form(
            key: formkey,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    Students records = widget.box2.getAt(widget.index2);
                    return TextFormField(
                      // ignore: prefer_const_constructors
                      initialValue: widget.name2,

                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        hintText: 'Name',
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(),
                      ),

                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*required';
                        } else if (value.trim().isEmpty) {
                          return 'please enter a name';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          records.name = value;
                          records.save();
                        });
                      },
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    Students records = widget.box2.getAt(widget.index2);
                    return TextFormField(
                      cursorColor: Colors.black,
                      initialValue: widget.age2,
                      decoration: InputDecoration(
                        hintText: 'Age',
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*required';
                        } else if (value.trim().isEmpty) {
                          return 'please enter a age';
                        }
                      },
                      onChanged: (value) {
                        setState(() {
                          records.age = value;
                          records.save();
                        });
                      },
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Builder(builder: (context) {
                    Students records = widget.box2.getAt(widget.index2);
                    return TextFormField(
                      cursorColor: Colors.black,
                      // ignore: prefer_const_constructors
                      initialValue: widget.place2,
                      decoration: InputDecoration(
                        hintText: 'Place',
                        fillColor: Colors.grey[300],
                        filled: true,
                        enabledBorder: InputBorder.none,
                        focusedBorder: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '*required';
                        } else if (value.trim().isEmpty) {
                          return 'please enter a place';
                        }
                      },
                      onChanged: (value) {
                        final results = Hive.box<Students>('records');

                        setState(() {
                          records.place = value.trim();
                          records.save();
                        });
                      },
                    );
                  }),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Cancel'),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red.shade800),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      ElevatedButton(
                        onPressed: addStudent,
                        child: Text('Save'),
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.green.shade500)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  addStudent() {
    if (formkey.currentState!.validate()) {
      Students records = widget.box2.getAt(widget.index2);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) => FullDetails(
              name: records.name,
              age: records.age,
              place: records.place,
              index: widget.index2,
              pic: records.pic,
              box: widget.box2)));
    }
  }

// -------------------------------------------------------------------------------------------------------------------
  // Widget ProfileImage(pic) {
  //   if (pic != null) {
  //     Uint8List imageBytes = base64Decode(pic);
  //     return CircleAvatar(
  //       child: GestureDetector(
  //         onTap: () => pickImage(ImageSource.gallery),
  //         child: Image.memory(
  //           imageBytes,

  //           // color: Colors.black,
  //           fit: BoxFit.cover,
  //         ),
  //       ),
  //     );
  //   }
  //   return GestureDetector(
  //     onDoubleTap: () => pickImage(ImageSource.camera),
  //     child: CircleAvatar(
  //       backgroundImage: AssetImage(
  //         "assets/images/image_upload_placeholder.jpg",
  //       ),
  //       backgroundColor: Colors.amber,
  //       radius: 70,
  //     ),
  //     onTap: () => pickImage(ImageSource.gallery),
  //   );
  // }

  // File? image;
  // dynamic path;
  // pickImage(source) async {
  //   final image = await ImagePicker().pickImage(source: source);
  //   if (image != null) {
  //     Uint8List imageBytes = await image.readAsBytes();
  //     widget.pic = base64Encode(imageBytes);
  //   }
  //   setState(
  //     () {
  //       if (image != null) {
  //         path = image.path;
  //       }
  //     },
  //   );
  // }
}
