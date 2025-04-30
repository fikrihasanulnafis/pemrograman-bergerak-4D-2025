import 'package:flutter/material.dart';

class HotPlaceCard extends StatelessWidget {
  final VoidCallback onTap;

  const HotPlaceCard({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 250,
        margin: EdgeInsets.only(right: 12),
      child: Card(
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  child: Row(
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/images/image.jpg',
          width: 100,
          height: 100,
          fit: BoxFit.cover,
        ),
      ),
      SizedBox(width: 8),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "National Park Yosemite",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  Icon(Icons.location_on, size: 12, color: Colors.grey),
                  SizedBox(width: 4),
                  Text("California", style: TextStyle(fontSize: 11)),
                ],
              ),
            ],
          ),
        ),
      ),
    ],
  ),
),
      ),
    );
  }
}
