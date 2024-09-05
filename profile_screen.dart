import 'package:abmbulance/components/button.dart';
import 'package:abmbulance/view/loginscreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 70,
              backgroundColor: Color(0xFFFEE1FF),
              child: Image(
                image: AssetImage('assets/profile.png'),
                height: 95,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'HAROON MASIH',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text('1610146938045', style: TextStyle(fontSize: 20)),
            Text('03469107053', style: TextStyle(fontSize: 20)),
            Text('HAROONMASIH133@GMAIL.COM', style: TextStyle(fontSize: 20)),
            Text('HOTI MARDAN', style: TextStyle(fontSize: 20)),
            SizedBox(
              height: 20,
            ),
            Text(
              'YOUR CNIC',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Image(
              image: AssetImage('assets/CNIC.png'),
              height: 170,
            ),
            Container(
              margin: EdgeInsets.only(top: 120),
              child: button(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icons.logout,
                btnName: 'LOGOUT',
                btnHeight: 55,
                fontSize: 20,
                textColor: Colors.white,
                btnColor: Color(0xFFFF3F3F),
                btnWidth: 360,
              ),
            )
          ],
        ),
      ),
    );
  }
}
