import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:snapplant/pages/preview.dart';
import 'package:snapplant/pages/results.dart';
import 'package:snapplant/widgets/daily_tip.dart';
import 'package:snapplant/widgets/greetings.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ImagePicker _picker = ImagePicker();
  Future<void> getImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      if (!mounted) return;
      if (pickedFile != null) {
        Widget nextScreen = source == ImageSource.camera
            ? ResultsPage(
                imagePath: File(pickedFile.path),
              )
            : PreviewPage(imagePath: File(pickedFile.path));
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => nextScreen));
      }
    } on PlatformException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("There was an error taking the picture"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const btnPadding = EdgeInsets.symmetric(
      horizontal: 15,
      vertical: 10,
    );
    final btnStyle = ElevatedButton.styleFrom(
      padding: btnPadding,
      shape: const StadiumBorder(),
      elevation: 0,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text('Snap Plant'),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(15),
        children: [
          const Greetings(),
          const DailyTip(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset(
                'assets/arrow.json',
                width: 45,
              ),
              const Text(
                "Discover plant disease",
                style: TextStyle(
                  fontSize: 20,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "You're not alone in this. We're here to help you identify and treat your plant disease.",
          ),
          const SizedBox(
            height: 4,
          ),
          const Text(
            "Just take a picture of your plant or choose an already taken image from your gallery and we'll do the rest!",
          ),
          const SizedBox(
            height: 8,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              'assets/old_woman.jpg',
              width: double.maxFinite,
              fit: BoxFit.cover,
              height: 250,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },
                  style: btnStyle,
                  child: const Text('Choose from gallery')),
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera);
                },
                style: btnStyle,
                child: const Text('Take a picture'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
