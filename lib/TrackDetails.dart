import 'package:flutter/material.dart';

class TrackDetails extends StatefulWidget {
  const TrackDetails({super.key});

  @override
  State<TrackDetails> createState() => _TrackDetailsState();
}

class _TrackDetailsState extends State<TrackDetails> {
  // 🔹 वही static points with address (MiniMapCycler जैसा)
  final List<Map<String, String>> _locations = const [
    {
      "title": "Location 1",
      "latlng": "Lat 28.57000, Lng 77.32100",
      "address": "Sector 62, Noida, Uttar Pradesh, India"
    },
    {
      "title": "Location 2",
      "latlng": "Lat 28.56720, Lng 77.35380",
      "address": "Sector 63, Noida, Uttar Pradesh, India"
    },
    {
      "title": "Location 3",
      "latlng": "Lat 28.58270, Lng 77.35260",
      "address": "Border of Sector 62/63, Noida"
    },
    {
      "title": "Location 4",
      "latlng": "Lat 28.53550, Lng 77.39100",
      "address": "Sector 18, Noida, Uttar Pradesh, India"
    },
    {
      "title": "Location 5",
      "latlng": "Lat 28.50130, Lng 77.41090",
      "address": "Sector 93A, Noida, Uttar Pradesh, India"
    },
    {
      "title": "Location 6",
      "latlng": "Lat 28.45950, Lng 77.50400",
      "address": "Noida - Greater Noida border"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Details"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _locations.length,
        itemBuilder: (context, index) {
          final loc = _locations[index];
          return Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    loc["title"]!,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    loc["latlng"]!,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    loc["address"]!,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
