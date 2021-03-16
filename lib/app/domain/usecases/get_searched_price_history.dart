import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/repositories/history_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class GetSearchedPriceHistory extends UseCase<List<HistoryJewelry>, Params> {
  final HistoryRepository repository;

  GetSearchedPriceHistory({@required this.repository});

  @override
  Future<Either<Failure, List<HistoryJewelry>>> call(Params parms) {
    return repository.getHistoryData();
  }
}

class Params extends Equatable {
  // daily, modthly, yearly
  final String period;

  // buy, sell
  final String exchangeState;

  // gold, platinum, diamond
  final String jewelryType;

  Params(
      {@required this.period,
      @required this.exchangeState,
      @required this.jewelryType});

  @override
  List<Object> get props => [period, exchangeState, jewelryType];
}
