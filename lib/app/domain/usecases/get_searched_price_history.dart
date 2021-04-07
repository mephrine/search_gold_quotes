import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:search_gold_quotes/app/domain/entities/history_jewelry.dart';
import 'package:search_gold_quotes/app/domain/repositories/history_repository.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/core/values/strings.dart';

class GetSearchedPriceHistory extends UseCase<HistoryJewelryList, Params> {
  final HistoryRepository repository;

  GetSearchedPriceHistory({@required this.repository});

  @override
  Future<Either<Failure, HistoryJewelryList>> call(Params params) {
    return repository.getHistoryData(params);
  }
}

class Params extends Equatable {
  // gold, platinum, silver
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

  String toSortTitleInScreen() {
    switch (this) {
      case Period.daily:
        return Strings.sortPeriodDaily;
      case Period.monthly:
        return Strings.sortPeriodMontly;
      case Period.yearly:
        return Strings.sortPeriodYearly;
      default:
        return '';
    }
  }
}

enum ExchangeState { buy, sell }

extension ExchangeStateParams on ExchangeState {
  String toParams() {
    return describeEnum(this);
  }

  String toSortTitleInScreen() {
    switch (this) {
      case ExchangeState.buy:
        return Strings.sortExchangeStateBuy;
      case ExchangeState.sell:
        return Strings.sortExchangeStateSell;
      default:
        return '';
    }
  }
}

enum JewelryType { gold, platinum, silver }

extension JewelryTypeParams on JewelryType {
  String toParams() {
    return describeEnum(this);
  }

  String toSortTitleInScreen() {
    switch (this) {
      case JewelryType.gold:
        return Strings.jewelryGold;
      case JewelryType.platinum:
        return Strings.jewelryPlatinum;
      case JewelryType.silver:
        return Strings.jewelrySilver;
      default:
        return '';
    }
  }
}
