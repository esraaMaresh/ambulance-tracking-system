import 'package:abmbulance/components/button.dart';
import 'package:abmbulance/view/record_screen.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({super.key});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isPhotoTaken = false;

  Future<void> _takePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _isPhotoTaken = true;
      });
      print('Picture saved to ${photo.path}');
    }
  }

  @override

  /// The photo is displayed in the same AlertDialog as the button.
  ///
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Row(
                  children: [
                    Text(
                      'BOOK AN AMBULANCE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Image(image: AssetImage('assets/ambulance.png'))
                  ],
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Major'),
                  Text('Minor'),
                ],
              ),
              Container(
                height: 540,
                width: 350,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/map.png'), fit: BoxFit.fill),
                  // border: Border.all(color: Color(0xFFFF3F3F)),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 65, right: 5, left: 5),
                child: Row(
                  children: [
                    button(
                        onPressed: () {
                          _showDialog(context);
                        },
                        btnName: 'BOOK CASE',
                        btnHeight: 55,
                        fontSize: 20,
                        textColor: Colors.white,
                        btnColor: Color(0xFFFF3F3F),
                        btnWidth: 280),
                    SizedBox(
                      width: 8,
                    ),
                    Container(
                        height: 55,
                        width: 65,
                        decoration: BoxDecoration(
                          color: Color(0xFFFF3F3F),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: _isPhotoTaken
                            ? Icon(Icons.check, size: 30, color: Colors.green)
                            : MaterialButton(
                                onPressed: _takePhoto,
                                child: Icon(
                                  Icons.upload,
                                  color: Colors.white,
                                ),
                              )),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

void _showDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert',
            style: TextStyle(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'Are you sure to book this case?',
            textAlign: TextAlign.center,
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Divider(
                  thickness: 2,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF68008C),
                    ),
                  ),
                ),
                // Container(
                //   width: 1,
                //   //divider width
                //   height: 40,
                //   //divider height
                //   color: Colors.black,
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RecordScreen()));
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: Color(0xFF68008C),
                    ),
                  ),
                ),
              ],
            ),
          ],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: BorderSide(color: Colors.black),
          ),
          backgroundColor: Colors.white,
        );
      });
}
