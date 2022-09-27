// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:snapplant/home.dart';
import 'package:snapplant/services/api.dart';
import 'package:snapplant/widgets/remedy.dart';

class ResultsPage extends StatefulWidget {
  const ResultsPage({
    Key? key,
    required this.imagePath,
  }) : super(key: key);
  final File imagePath;
  @override
  State<ResultsPage> createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  Future<void> handleRefresh() async {
    analyzePlant(widget.imagePath.path);
  }

  @override
  Widget build(BuildContext context) {
    final h6 = Theme.of(context).textTheme.headline6;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Predictions"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: handleRefresh,
        child: FutureBuilder(
          future: analyzePlant(widget.imagePath.path),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                    "There was an error finding the disease, try again later"),
              );
            }
            if (snapshot.hasData) {
              final data = snapshot.data;
              final String type = data['class'];
              final confidence = data['confidence'];
              final String lowercaseType = type.toLowerCase();
              return ListView(
                children: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: MediaQuery.of(context).size.height * 0.45,
                    ),
                    child: Image.file(
                      widget.imagePath,
                      width: double.maxFinite,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Condition :",
                              style: h6!.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              type,
                              style: h6.copyWith(
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Confidence :",
                              style: h6.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            Text(
                              '$confidence %',
                              style: h6,
                            ),
                          ],
                        ),
                        Remedy(lowercaseType: lowercaseType)
                      ],
                    ),
                  ),
                ],
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return const Center(
              child: Text("Something went wrong, try again later"),
            );
          },
        ),
      ),
    );
  }
}
