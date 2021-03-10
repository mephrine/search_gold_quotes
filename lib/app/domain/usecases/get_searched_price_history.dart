import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class GetSearchedPriceHistory extends UseCase<List<HistoryJewelry>, Params> {
  @override
  Future<Either<Failure, List<HistoryJewelry>>> call(Params parms) {
    return null;
  }
}

class Params extends Equatable {
  final String period;
  final String exchangeState;
  final String jewelryType;


  Params({
  @required this.period,
      @required this.exchangeState,
      @required this.jewelryType
  });

  @override
  List<Object> get props => [period, exchangeState, jewelryType];

}