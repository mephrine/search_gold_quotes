import 'package:flutter/material.dart';
import 'package:search_gold_quotes/app/presentation/style/TextStyles.dart';
import 'package:search_gold_quotes/core/values/strings.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoMetaDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return YoutubeValueBuilder(builder: (context, value) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Text(Strings.videoPlayerTitleDescription, value.metaData.title),
          const SizedBox(height: 10),
          _Text(Strings.videoPlayerChannelDescription, value.metaData.author),
          const SizedBox(height: 10),
          Row(
            children: [
              const _Text(
                'Speed',
                '',
              ),
              YoutubeValueBuilder(
                builder: (context, value) {
                  return DropdownButton(
                    value: value.playbackRate,
                    isDense: true,
                    underline: const SizedBox(),
                    items: PlaybackRate.all
                        .map(
                          (rate) => DropdownMenuItem(
                            child: Text(
                              '${rate}x',
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            value: rate,
                          ),
                        )
                        .toList(),
                    onChanged: (double newValue) {
                      if (newValue != null) {
                        context.ytController.setPlaybackRate(newValue);
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ],
      );
    });
  }
}

class _Text extends StatelessWidget {
  final String title;
  final String value;

  const _Text(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: '$title : ',
        style: TextPrimaryContrastingStyles.titleStyle(context),
        children: [
          TextSpan(
            text: value,
            style: TextPrimaryContrastingStyles.defaultStyle(context),
          ),
        ],
      ),
    );
  }
}
