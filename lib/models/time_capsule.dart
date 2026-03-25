import 'package:flutter/material.dart';

class TimeCapsule {
  final String id;
  final String title;
  final String message;
  final DateTime creationDate;
  final DateTime unlockDate;
  final Color colorCode;

  TimeCapsule({
    required this.id,
    required this.title,
    required this.message,
    required this.creationDate,
    required this.unlockDate,
    required this.colorCode,
  });

  bool get isLocked => DateTime.now().isBefore(unlockDate);

  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'title' : title,
      'message' : message,
      'creationDate' : creationDate.toIso8601String(),
      'unlockDate' : unlockDate.toIso8601String(),
      'colorValue' : colorCode.value,
    };
  }

  factory TimeCapsule.fromMap(Map<String, dynamic> map) {
    return TimeCapsule(
      id: map['id'],
      title: map['title'],
      message: map['message'],
      creationDate: DateTime.parse(map['creationDate']),
      unlockDate: DateTime.parse(map['unlockDate']),
      colorCode: Color(map['colorValue']),
    );
  }
}