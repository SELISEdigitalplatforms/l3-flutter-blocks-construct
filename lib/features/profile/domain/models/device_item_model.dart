import 'package:flutter/material.dart';

class DeviceItemModel {
  final String name;
  final int sessions;
  final String lastAccessed;
  final IconData icon;
  bool isExpanded;

  DeviceItemModel({
    required this.name,
    required this.sessions,
    required this.lastAccessed,
    required this.icon,
    this.isExpanded = false,
  });
}
