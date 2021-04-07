import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';

class FamousQuotesAnimationWidget extends StatelessWidget {
  final String famousQuotes;

  FamousQuotesAnimationWidget({@required this.famousQuotes});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        children: [
          AnimatedTextKit(
            // speed: Duration(milliseconds: 300),
            repeatForever: true,
            animatedTexts: famousQuotes
                .split(' ')
                .map((element) => TypewriterAnimatedText(element,
                    textStyle:
                        TextPrimaryContrastingStyles.biggerStyle(context)))
                .toList(),
            pause: Duration(milliseconds: 300),
            displayFullTextOnTap: false,
            stopPauseOnTap: false,
          ),
          SizedBox(
            height: 20,
          ),
          Text('-${homeData.famousSayingData.famousSayingWriter}-',
              style: TextPrimaryContrastingStyles.defaultStyle(context)),
        ],
      ),
    );
  }
}
