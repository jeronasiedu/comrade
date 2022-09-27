import 'package:flutter/material.dart';

class DailyTip extends StatelessWidget {
  const DailyTip({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: Card(
        elevation: 0.2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Icon(
                      Icons.lightbulb_outline,
                      size: 28,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Text(
                    "Today's tip",
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(top: 8.0),
                child: Text(
                  "The best way to grow healthy plants is by providing water, nutrients, and the proper environmental conditions for your type of plant.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
