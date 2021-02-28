import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:search_gold_quotes/app/domain/entities/home_data.dart';
import 'package:search_gold_quotes/app/domain/repositories/home_repository.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/core/error/failures.dart';
import 'package:search_gold_quotes/core/usecases/usecase.dart';

class GetHomeInfo extends UseCase<HomeData, NoParams> {
  final HomeRepository homeRepository;

  GetHomeInfo({
    @required this.homeRepository
  });

  @override
  Future<Either<Failure, HomeData>> call(NoParams params) async {
    return await homeRepository.getHomeData();
  }
}