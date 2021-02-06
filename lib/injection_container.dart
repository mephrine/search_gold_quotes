import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';
import 'package:search_gold_quotes/core/presentation/utils/input_converter.dart';
import 'package:search_gold_quotes/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:search_gold_quotes/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:search_gold_quotes/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/features/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final di = GetIt.instance;

void init() async {
  //! Featurs - NumberTrivia

  // Bloc
  di.registerFactory(() =>
      NumberTriviaBloc(
        concrete: di(),
        random: di(),
        inputConverter: di(),
      ));

  // Use cases
  di.registerLazySingleton(() => GetConcreteNumberTrivia(di()));
  di.registerLazySingleton(() => GetRandomNumberTrivia(di()));

  // Repository
  di.registerLazySingleton<NumberTriviaRepository>(
          () =>
          NumberTriviaRepositoryImpl(
            remoteDataSource: di(),
            localDataSource: di(),
            networkInfo: di(),
          ));

  // Data Sources
  di.registerLazySingleton<NumberTriviaRemoteDataSource>(() =>
      NumberTriviaRemoteDataSourceImpl(httpClient: di(),));
  di.registerLazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImpl(preferences: di(),));

  //! Core
  di.registerLazySingleton(() => InputConverter());
  di.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(di()));

  //! External
  final sharePreferences = await SharedPreferences.getInstance();
  di.registerLazySingleton(() => sharePreferences);
  di.registerLazySingleton(() => http.Client());
  di.registerLazySingleton(() => DataConnectionChecker());
}

void initFeatures() {}

void initCore() {}

void initExternal() {}
