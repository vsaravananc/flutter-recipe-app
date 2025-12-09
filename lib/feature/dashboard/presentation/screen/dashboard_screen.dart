import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(child: Text("DashBoard-Screen")),
      bottomNavigationBar: Container(
        height: 55,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}
