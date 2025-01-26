import 'package:flutter/material.dart';

class BottomNavigationEntity{
  String title;
  IconData icon;
  Widget page;

  BottomNavigationEntity({
    required this.title, 
    required this.icon, 
    required this.page
  });
}