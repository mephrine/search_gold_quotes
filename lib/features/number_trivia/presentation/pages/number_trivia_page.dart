import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/features/number_trivia/data/models/number_trivia_model.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';
import 'package:search_gold_quotes/features/number_trivia/presentation/pages/trivia_display.dart';
import 'package:search_gold_quotes/injection_container.dart';

import 'loading_widget.dart';
import 'message_display.dart';

class NumberTriviaPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: buildBody(context),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => sl<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10),
                // top half
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                    builder: (bloc, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start Searching!!',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(
                        numberTrivia: state.trivia
                    );
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                }),
                SizedBox(height: 20),
                //bottom half
                Column(
                  children: [
                    Placeholder(
                      fallbackHeight: 40,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Placeholder(
                          fallbackHeight: 30,
                        )),
                        SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: Placeholder(
                          fallbackHeight: 30,
                        )),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}


