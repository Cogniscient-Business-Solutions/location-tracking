import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  factory LocationService() => _instance;
  LocationService._internal();

  final List<LatLng> _points = const [
    LatLng(28.5700, 77.3210), // Sector 62
    LatLng(28.5672, 77.3538), // Sector 63
    LatLng(28.5827, 77.3526), // Sector 62/63 border
    LatLng(28.5355, 77.3910), // Sector 18
    LatLng(28.5013, 77.4109), // Sector 93A
    LatLng(28.4595, 77.5040), // Noida-GN border
  ];

  final StreamController<LatLng> _controller = StreamController.broadcast();
  Stream<LatLng> get locationStream => _controller.stream;

  Timer? _timer;
  int _currentIndex = 0;

  void startTracking() {
    _timer?.cancel();
    _controller.add(_points[_currentIndex]); // पहला point भेजो
    _timer = Timer.periodic(const Duration(seconds: 4), (_) {
      _currentIndex++;
      if (_currentIndex >= _points.length) {
        _currentIndex = 0; // loop reset
      }
      _controller.add(_points[_currentIndex]);
    });
  }

  void stopTracking() {
    _timer?.cancel();
  }
}
