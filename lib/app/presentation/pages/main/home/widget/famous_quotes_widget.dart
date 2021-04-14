import 'package:animated_text_kit/animated_text_kit.dart';
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
            AnimatedTextKit(
              // speed: Duration(milliseconds: 300),
              repeatForever: false,
              animatedTexts: [
                TyperAnimatedText(famousQuotes.replaceAll('\\n', ' '),
                    textStyle:
                        TextPrimaryContrastingStyles.biggerStyle(context),
                    textAlign: TextAlign.center),
              ],
              // famousQuotes
              //     .split(' ')
              //     .map((element) => TypewriterAnimatedText(element,
              //         textStyle:
              //             TextPrimaryContrastingStyles.biggerStyle(context)))
              //     .toList(),

              displayFullTextOnTap: false,
              stopPauseOnTap: false,
              totalRepeatCount: 1,
            )
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
