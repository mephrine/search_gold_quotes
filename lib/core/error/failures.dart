import 'package:equatable/equatable.dart';
import 'package:search_gold_quotes/core/error/exceptions.dart';

abstract class Failure extends Equatable {
  List<dynamic> properties = const<dynamic>[];
  Failure([this.properties]);

  @override
  List<dynamic> get props {
    return this.properties;
  }
}

class ServerFailure extends Failure {
  ServerFailure(List properties) : super(properties);
}

class CacheFailure extends Failure {
  CacheFailure(List properties) : super(properties);

}