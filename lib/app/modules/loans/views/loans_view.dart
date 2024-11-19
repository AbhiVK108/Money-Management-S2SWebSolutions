import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/loans_controller.dart';

class LoansView extends GetView<LoansController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LoansView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'LoansView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
