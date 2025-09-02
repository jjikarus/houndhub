import 'package:flutter/foundation.dart';
import 'package:location/location.dart';

class WalkService with ChangeNotifier {
  final Location _location = Location();
  bool _isTracking = false;
  DateTime? _startTime;
  Duration _currentDuration = Duration.zero;

  Future<bool> _checkPermissions() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) return false;
    }

    PermissionStatus permission = await _location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _location.requestPermission();
      if (permission != PermissionStatus.granted) return false;
    }

    return true;
  }

  Future<void> startWalk() async {
    if (await _checkPermissions()) {
      _isTracking = true;
      _startTime = DateTime.now();
      _currentDuration = Duration.zero;
      print('Walk started at $_startTime');
      notifyListeners();
    }
  }

  Future<void> endWalk() async {
    if (_isTracking) {
      _isTracking = false;
      final endTime = DateTime.now();
      _currentDuration = endTime.difference(_startTime!);
      print('Walk ended. Duration: ${_currentDuration.inMinutes} minutes');
      _startTime = null;
      notifyListeners();
    }
  }

  String get formattedDuration {
    if (!_isTracking) return '00:00';
    final duration = DateTime.now().difference(_startTime!);
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool get isTracking => _isTracking;
  Duration get currentDuration => _currentDuration;
}