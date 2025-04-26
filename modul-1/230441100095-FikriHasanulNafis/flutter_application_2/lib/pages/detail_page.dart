import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final String imagePath;
  final String _currentTime = '9.40';
  const DetailPage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'National Park Yosemite',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(height: 16),
       ClipRRect(
  borderRadius: BorderRadius.circular(12),
  child: Image.asset(
    'assets/images/image.jpg',
    width: double.infinity,
    height: 500, // kamu bisa atur sesuai kebutuhan
    fit: BoxFit.cover, // menjaga agar gambar tetap memenuhi dan tidak gepeng
  ),
),

              SizedBox(height: 16),
              Text(
                'Lorem ipsum est donec non interdum amet phasellus egestas id dignissim.Lorem ipsum est donec non interdum amet phasellus egestas id dignissim in vestibulum augue ut a lectus rhoncus sed ullamcorper at vestibulum sed mus neque amet turpis placerat in luctus at eget egestas praesent congue semper in facilisis purus dis pharetra odio ullamcorper euismod a donec consectetur pellentesque pretium sapien proin tincidunt non augue turpis massa euismod quis lorem et feugiat ornare id cras sed eget adipiscing dolor urna mi sit a a auctor mattis urna fermentum facilisi sed aliquet odio at suspendisse posuere tellus pellentesque id quis libero fames blandit ullamcorper interdum eget placerat tortor cras nulla consectetur et duis viverra mattis libero scelerisque gravida egestas blandit tincidunt ullamcorper auctor aliquam leo urna adipiscing est ut ipsum consectetur id erat semper fames elementum rhoncus quis varius pellentesque quam neque vitae sit velit leo massa habitant tellus velit pellentesque cursus laoreet donec etiam id vulputate nisi integer eget gravida volutpat.',
                style: TextStyle(fontSize: 14, color: Colors.black87),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
