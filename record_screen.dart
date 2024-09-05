import 'package:abmbulance/components/booking.dart';
import 'package:flutter/material.dart';

class RecordScreen extends StatelessWidget {
  const RecordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 35, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
            SizedBox(
              height: 20,
            ),
            Text(
              'PENDING',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            BookingCard(
              // status: 'Pending',
              name: 'Haroon Masih',
              phone: '+92 313 1907600',
              address: 'Hoti Mardan',
              type: 'Medical',
              date: '2/11/2023 - 19:00',
              statusColor: Colors.grey,
              btnName: 'PENDING',
              btnColor: Color(0xFFF5DD00),
            ),
            Divider(
              height: 30.0,
              thickness: 2.0,
              color: Colors.grey,
            ),
            Text(
              'COMPLETED',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            BookingCard(
              // status: 'Pending',
              name: 'Haroon Masih',
              phone: '+92 313 1907600',
              address: 'Hoti Mardan',
              type: 'Medical',
              date: '2/11/2023 - 19:00',
              statusColor: Colors.grey,
              btnName: 'COMPLETED',
              btnColor: Color(0xFF00C136),
            ),
            Divider(
              height: 30.0,
              thickness: 2.0,
              color: Colors.grey,
            ),
            Text(
              'CANCELED',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            BookingCard(
              // status: 'Pending',
              name: 'Haroon Masih',
              phone: '+92 313 1907600',
              address: 'Hoti Mardan',
              type: 'Medical',
              date: '2/11/2023 - 19:00',
              statusColor: Colors.grey,
              btnName: 'CANCELED',
              btnColor: Color(0xFFFF4848),
            ),
            Divider(
              height: 30.0,
              thickness: 2.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
