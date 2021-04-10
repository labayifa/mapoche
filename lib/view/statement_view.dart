import 'package:flutter/material.dart';

class StatementView extends StatefulWidget {
  @override
  _StatementViewState createState() => _StatementViewState();
}

class _StatementViewState extends State<StatementView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(
          'Relevé'
      ),
    );
  }
}
