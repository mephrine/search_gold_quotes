import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Failure extends Equatable {
  List<dynamic> properties = const <dynamic>[];
  Failure([this.properties]);

  @override
  List<dynamic> get props {
    return this.properties;
  }
}

// ignore: must_be_immutable
class ServerFailure extends Failure {}

// ignore: must_be_immutable
class CacheFailure extends Failure {}

// ignore: must_be_immutable
class ParseFailure extends Failure {}
