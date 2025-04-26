
import 'package:flutter/material.dart';
import '../pages/detail_page.dart';
import '../widgets/hot_place_card.dart';
import '../widgets/hotel_card.dart';

class TravelHomePage extends StatefulWidget {
  const TravelHomePage({Key? key}) : super(key: key);

  @override
  _TravelHomePageState createState() => _TravelHomePageState();
}

class _TravelHomePageState extends State<TravelHomePage> {
  final String dummyText =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis, doloribus. Eos, accusantium doloremque! Tenetur, sed.Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quis, doloribus. Eos, accusantium doloremque! Tenetur, sed. ';
  String _currentTime = '9.40';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_currentTime,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                  Row(
                    children: [
                      Icon(Icons.signal_cellular_4_bar, size: 16),
                      SizedBox(width: 6),
                      Icon(Icons.wifi, size: 16),
                      SizedBox(width: 6),
                      Icon(Icons.battery_full, size: 16),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Hi, User',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                  ),
                ],
              ),
              SizedBox(height: 24),
              sectionHeader('Hot Places'),
              SizedBox(height: 8),
              SizedBox(
                height: 110,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index) => HotPlaceCard(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            imagePath: 'assets/images/gambar${index + 1}.jpeg',
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 24),
              sectionHeader('Best Hotels'),
              SizedBox(height: 8),
              ...List.generate(
                4,
                (index) => HotelCard(description: dummyText),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text('See All', style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}

