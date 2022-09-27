// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapplant/pages/results.dart';

class PreviewPage extends StatelessWidget {
  const PreviewPage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);
  final File imagePath;
  @override
  Widget build(BuildContext context) {
    final btnStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      shape: const StadiumBorder(),
      elevation: 0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          InteractiveViewer(
            child: Image.file(
              imagePath,
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.45,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: btnStyle.copyWith(
                      backgroundColor: MaterialStateProperty.all(
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ),
                    ),
                    child: const Text('Choose another image ')),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ResultsPage(
                        imagePath: imagePath,
                      ),
                    ));
                  },
                  style: btnStyle,
                  child: const Text('Use this image'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
