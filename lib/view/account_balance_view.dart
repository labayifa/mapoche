import 'package:flutter/material.dart';

class AccountBalanceView extends StatefulWidget {
  @override
  _AccountBalanceViewState createState() => _AccountBalanceViewState();
}

class _AccountBalanceViewState extends State<AccountBalanceView>
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
          'Recap'
      ),
    );
  }
}
