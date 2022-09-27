// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:snapplant/translate/translations.dart';

class Remedy extends StatefulWidget {
  const Remedy({
    Key? key,
    required this.lowercaseType,
  }) : super(key: key);
  final String lowercaseType;

  @override
  State<Remedy> createState() => _RemedyState();
}

class _RemedyState extends State<Remedy> {
  Map currentTranslation = EnglishTranslations;
  String healthyText = healthyTextEnglish;
  String buttonText = "Translate to Twi";

  void changeTranslation() {
    setState(() {
      if (currentTranslation == EnglishTranslations) {
        currentTranslation = twiTranslations;
        buttonText = "Translate to English";
      } else {
        currentTranslation = EnglishTranslations;
        buttonText = "Translate to Twi";
      }
    });
  }

  void changeTextToTwi() {
    setState(() {
      if (healthyText == healthyTextEnglish) {
        buttonText = "Translate to English";
        healthyText = healthyTextTwi;
      } else {
        healthyText = healthyTextEnglish;
        buttonText = "Translate to Twi";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final h6 = Theme.of(context).textTheme.headline6;
    final btnStyle = ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      fixedSize: Size(MediaQuery.of(context).size.width * 0.9, 40),
      shape: const StadiumBorder(),
      elevation: 0,
    );
    return widget.lowercaseType == "healthy"
        ? Padding(
            padding: EdgeInsets.symmetric(
              vertical: 8.0,
            ),
            child: Column(
              children: [
                Text(
                  healthyText,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: changeTextToTwi,
                    style: btnStyle,
                    child: Text(buttonText),
                  ),
                ),
              ],
            ),
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "Remedy",
                  style: h6!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              ...List.generate(
                currentTranslation[widget.lowercaseType].length,
                (index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: CircleAvatar(
                            radius: 18,
                            child: Text('${index + 1}'),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            currentTranslation[widget.lowercaseType][index],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: changeTranslation,
                  style: btnStyle,
                  child: Text(buttonText),
                ),
              ),
            ],
          );
  }
}