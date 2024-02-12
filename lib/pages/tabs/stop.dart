import 'package:flutter/material.dart';

class StopPage extends StatefulWidget {
  const StopPage({super.key});

  @override
  State<StopPage> createState() => _StopPageState();
}

class _StopPageState extends State<StopPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("停止组件"),
    );
  }
}