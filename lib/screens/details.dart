import 'package:flutter/material.dart';

import 'index.dart';

class CatDetails extends StatelessWidget {
  final Cat cat;
  const CatDetails(this.cat, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cat Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            SizedBox(
              width: 200,
              child:Image.network(cat.picture),
            ),
            Text(
              cat.title,
              style: const TextStyle(fontSize: 22),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                cat.content,
                style: const TextStyle(fontSize: 16),
              ),
            )
          ],
        ),
      ),
    );
  }}