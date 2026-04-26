import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const V2RayScreen());
}

class V2RayScreen extends StatefulWidget {
  const V2RayScreen({super.key});
  @override
  State<V2RayScreen> createState() => _V2RayScreenState();
}

class _V2RayScreenState extends State<V2RayScreen> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("V2Ray Strict Mode")),
        body: Center(
          child: Text("data"),
        ),
      ),
    );
  }
}