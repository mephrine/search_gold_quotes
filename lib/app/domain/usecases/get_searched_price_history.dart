import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/repositories/history_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';
import 'package:meta/meta.dart';

class GetSearchedPriceHistory extends UseCase<HistoryJewelryList, Params> {
  final HistoryRepository repository;

  GetSearchedPriceHistory({@required this.repository});

  @override
  Future<Either<Failure, HistoryJewelryList>> call(Params params) {
    return repository.getHistoryData(params);
  }
}

class Params extends Equatable {
  // gold, platinum, diamond
  final JewelryType jewelryType;

  // daily, modthly, yearly
  final Period period;

  // buy, sell
  final ExchangeState exchangeState;

  Params(
      {@required this.jewelryType,
      @required this.period,
      @required this.exchangeState});

  String toRequestURL(String historyURL) {
    return historyURL +
        "/" +
        jewelryType.toParams() +
        "/" +
        exchangeState.toParams() +
        "/" +
        period.toParams();
  }

  @override
  List<Object> get props => [period, exchangeState, jewelryType];
}

enum Period { daily, monthly, yearly }

extension PeriodParams on Period {
  String toParams() {
    return describeEnum(this);
  }
}

enum ExchangeState { buy, sell }

extension ExchangeStateParams on ExchangeState {
  String toParams() {
    return describeEnum(this);
  }
}

enum JewelryType { gold, platinum, diamond }

extension JewelryTypeParams on JewelryType {
  String toParams() {
    return describeEnum(this);
  }
}
