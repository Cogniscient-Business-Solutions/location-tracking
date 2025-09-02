/*
import 'package:flutter/material.dart';
import 'MiniMapCycler.dart';
import 'TrackDetails.dart';
import 'mini_map_cycler.dart';
import 'track_details.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final List<String> _locationLogs = [];

  void _addLocation(String text) {
    setState(() {
      _locationLogs.insert(0, text); // latest top पर
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Admin Dashboard"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MiniMapCycler(onLocationUpdate: _addLocation),
                  ),
                );
              },
              child: const Text("Open Mini Map Tracker"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TrackDetails(locationLogs: _locationLogs),
                  ),
                );
              },
              child: const Text("View Track Details"),
            ),
          ],
        ),
      ),
    );
  }
}
*/
