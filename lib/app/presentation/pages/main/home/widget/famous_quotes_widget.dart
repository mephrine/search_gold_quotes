import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';

class FamousQuotesWidget extends StatelessWidget {
  final String famousQuotes;
  final String writer;

  FamousQuotesWidget({@required this.famousQuotes, @required this.writer});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          children: [
            Text(famousQuotes.replaceAll('\\n', ' '),
                style: TextPrimaryContrastingStyles.biggerStyle(context),
                textAlign: TextAlign.center),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text('-$writer-',
            style: TextPrimaryContrastingStyles.defaultStyle(context)),
      ],
    );
  }
}
