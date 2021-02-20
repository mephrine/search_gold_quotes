import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_gold_quotes/app/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';
import 'package:search_gold_quotes/app/number_trivia/presentation/widgets/trivia_controls.dart';
import 'package:search_gold_quotes/app/number_trivia/presentation/widgets/trivia_display.dart';
import 'package:search_gold_quotes/core/di/injection_container.dart';

import '../widgets/loading_widget.dart';
import '../widgets/message_display.dart';

class NumberTriviaPage extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
        create: (_) => container<NumberTriviaBloc>(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                }),
                SizedBox(height: 20),
                TriviaControls(),
                //bottom half
              ],
            ),
          ),
        ));
  }
}

