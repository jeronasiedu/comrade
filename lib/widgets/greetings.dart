import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Greetings extends StatelessWidget {
  const Greetings({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final headingText = Theme.of(context).textTheme.headline5;
    final format = DateFormat('E, MMMM d, yyyy');
    final todayDate = DateTime.now();
    final formattedDate = format.format(todayDate);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 4),
              child: Text(
                "Hello",
                style: headingText,
              ),
            ),
            Text(
              "Farmers",
              style: headingText!.copyWith(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
        Text(
          formattedDate,
          style: Theme.of(context).textTheme.subtitle2,
        ),
      ],
    );
  }
}
