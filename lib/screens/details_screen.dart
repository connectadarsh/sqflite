import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sq_flite/db/model/model.dart';

class DataScreen extends StatelessWidget {
  final StudentModel data;
  const DataScreen({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white54,
        centerTitle: true,
        title: const Text(
          'Details',
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                  height: 250, width: 250, child: Image.file(File(data.image))),
              Text(style: const TextStyle(fontSize: 50), data.name),
              Text(style: const TextStyle(fontSize: 30), data.age),
              Text(style: const TextStyle(fontSize: 20), data.mobile),
            ],
          ),
        ),
      ),
    );
  }
}
