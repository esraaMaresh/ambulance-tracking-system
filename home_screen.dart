import 'package:abmbulance/components/button.dart';
import 'package:abmbulance/components/home_tiles.dart';
import 'package:abmbulance/view/booking_screen.dart';
import 'package:abmbulance/view/profile_screen.dart';
import 'package:abmbulance/view/record_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DatabaseFactory? get databaseFactoryFfi => null;

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  void main() {
    // Initialize databaseFactory
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    // Now you can use the openDatabase API
    openDatabase(
      'CREATE TABLE emergencyServices (id INTEGER PRIMARY KEY, emergency_name_image BLOB)',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE emergencyServices (id INTEGER PRIMARY KEY, emergency_name_image BLOB)')
            .then((value) => {
                  //// Note: the emergency service must have 2 columns the name of the service ex: Fire and it's image, but since it is considered as a full image in the code i've created it in the DB as an image
                  print('Table created'),
                })
            .catchError((error) {
          'Error when creating table ${error.toString()}';
        });
      },
    );
  }

  @override
  void initState() {
    super.initState();
    createDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 35, right: 10, left: 10),
        child: Column(
          children: [
            Row(
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
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: false,
                mainAxisSpacing: 10,
                children: [
                  homeTiles(
                      image: AssetImage('assets/medical.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingScreen()));
                      }),
                  homeTiles(
                      image: AssetImage('assets/accident.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingScreen()));
                      }),
                  homeTiles(
                      image: AssetImage('assets/fire.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingScreen()));
                      }),
                  homeTiles(
                      image: AssetImage('assets/other.png'),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookingScreen()));
                      }),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            button(
                onPressed: () {
                  _makePhoneCall('1122');

                  // if (await canLaunch('tel:1122')) {
                  //   await launch('tel:1122');
                  // } else {
                  //   throw 'Could not call 1122';
                  // }
                },
                btnName: '1122 CALL',
                btnHeight: 55,
                fontSize: 25,
                textColor: Colors.white,
                btnColor: Color(0xFFFF3F3F),
                btnWidth: 350),
            SizedBox(
              height: 155,
            ),
            Container(
              margin: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RecordScreen()));
                      },
                      icon: Icons.assignment,
                      btnName: 'My Record',
                      btnHeight: 55,
                      fontSize: 20,
                      textColor: Colors.white,
                      btnColor: Color(0xFFFF3F3F),
                      btnWidth: 170),
                  // SizedBox(
                  //   width: 30,
                  // ),
                  button(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProfileScreen()));
                      },
                      icon: Icons.person,
                      btnName: 'Profile',
                      btnHeight: 55,
                      fontSize: 20,
                      textColor: Colors.white,
                      btnColor: Color(0xFFFF3F3F),
                      btnWidth: 170),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  //database creation
  void createDatabase() async {
    var database = await openDatabase(
      //id column number
      //String service name
      //image service image
      'ambulance.db',
      version: 1,
      onCreate: (database, version) async {
        print('database created');
        await database
            .execute(
                'CREATE TABLE emergencyServices (id INTEGER PRIMARY KEY, emergency_name_image BLOB)')
            .then((value) => {
                  //// Note: the emergency service must have 2 columns the name of the service ex: Fire and it's image, but since it is considered as a full image in the code i've created it in the DB as an image
                  print('Table created'),
                })
            .catchError((error) {
          'Error when creating table ${error.toString()}';
        });
      },
      onOpen: (database) {
        print('database opened');
      },
    );
  }

  void insertDatabase() {}

  void updateDatabase() {}
}
