import 'dart:convert';

import 'package:chronos_capsulas_de_tiempo_digitales/models/time_capsule.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CapsuleProvider with ChangeNotifier {
  List<TimeCapsule> _capsules = [];

  List<TimeCapsule> get capsules => _capsules;

  CapsuleProvider() {
    _loadCapsules();
  }

  Future<void> _loadCapsules() async {
    final prefs = await SharedPreferences.getInstance();
    final String? data = prefs.getString('capsules');
    if (data != null) {
      final List<dynamic> decoded = jsonDecode(data);
      _capsules = decoded.map((e) => TimeCapsule.fromMap(e)).toList();
      _sortCapsules();
      notifyListeners();
    }
  }

  Future<void> addCapsule(TimeCapsule capsule) async {
    _capsules.add(capsule);
    _sortCapsules();
    await _saveCapsules();
    notifyListeners();
  }

  Future<void> deleteCapsule(String id) async {
    _capsules.removeWhere((element) => element.id == id);
    await _saveCapsules();
    notifyListeners();
  }
  
  void _sortCapsules() {
    _capsules.sort((a, b) => a.unlockDate.compareTo(b.unlockDate));
  }
  
  Future<void> _saveCapsules() async {
    final prefs = await SharedPreferences.getInstance();
    final String encoded = jsonEncode(_capsules.map((e) => e.toMap()).toList());
    await prefs.setString('capsules', encoded);
  }
}