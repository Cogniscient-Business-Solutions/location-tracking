import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MiniMapCycler extends StatefulWidget {
  const MiniMapCycler({super.key});

  @override
  State<MiniMapCycler> createState() => _MiniMapCyclerState();
}

class _MiniMapCyclerState extends State<MiniMapCycler> {
  GoogleMapController? _controller;
  Timer? _timer;
  int _currentIndex = 0;

  final List<LatLng> _points = const [
    LatLng(28.5700, 77.3210), // Sector 62
    LatLng(28.5672, 77.3538), // Sector 63
    LatLng(28.5827, 77.3526), // Sector 62/63 border
    LatLng(28.5355, 77.3910), // Sector 18
    LatLng(28.5013, 77.4109), // Sector 93A
    LatLng(28.4595, 77.5040), // Noida-GN border
  ];

  static const _zoom = 14.0;
  static const _interval = Duration(seconds: 4);

  List<LatLng> _visitedPoints = [];
  String _currentAddress = "Fetching address...";

  @override
  void initState() {
    super.initState();
    _resetTracking(); // पहली बार reset करके शुरू करेंगे
    _startTicker();
  }

  void _startTicker() {
    _timer?.cancel();
    _timer = Timer.periodic(_interval, (_) => _next());
  }

  void _next() {
    if (_currentIndex == _points.length - 1) {
      // ✅ जब आखिरी point पर पहुंच जाए तो reset करके फिर से शुरू करो
      _resetTracking();
      return;
    }

    setState(() {
      _currentIndex++;
      _visitedPoints.add(_points[_currentIndex]);
    });
    _animateTo(_points[_currentIndex]);
    _getAddress(_points[_currentIndex]);
  }

  Future<void> _getAddress(LatLng latLng) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
      if (placemarks.isNotEmpty) {
        Placemark p = placemarks.first;
        setState(() {
          _currentAddress =
          "${p.name}, ${p.locality}, ${p.administrativeArea}, ${p.country}";
        });
      }
    } catch (e) {
      setState(() {
        _currentAddress = "Address not found";
      });
    }
  }

  Future<void> _animateTo(LatLng target) async {
    if (_controller == null) return;
    await _controller!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: target, zoom: _zoom),
      ),
    );
  }

  void _resetTracking() {
    setState(() {
      _currentIndex = 0;
      _visitedPoints = [_points[0]];
      _currentAddress = "Fetching address...";
    });
    _animateTo(_points[0]);
    _getAddress(_points[0]);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = _points[_currentIndex];

    final marker = Marker(
      markerId: MarkerId('pt_$_currentIndex'),
      position: current,
      infoWindow: InfoWindow(title: 'Point ${_currentIndex + 1}'),
    );

    final polyline = Polyline(
      polylineId: const PolylineId('path'),
      points: _visitedPoints,
      width: 4,
      geodesic: true,
      color: Colors.blue,
    );

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: current, zoom: _zoom),
            onMapCreated: (c) {
              _controller = c;
              Future.delayed(const Duration(milliseconds: 300), () {
                _animateTo(current);
              });
            },
            markers: {marker},
            polylines: {polyline},
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
          ),

          // 🔹 नीचे Text Box with Lat/Lng + Address
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Location ${_currentIndex + 1}: "
                        "Lat ${current.latitude.toStringAsFixed(5)}, "
                        "Lng ${current.longitude.toStringAsFixed(5)}",
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _currentAddress,
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
