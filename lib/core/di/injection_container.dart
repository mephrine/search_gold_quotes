import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';
import 'package:search_gold_quotes/core/presentation/utils/input_converter.dart';
import 'package:search_gold_quotes/app/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:search_gold_quotes/app/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:search_gold_quotes/app/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/app/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

// Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  //! Featurs - NumberTrivia

  // Bloc
  sl.registerFactory(() =>
      NumberTriviaBloc(
        concrete: sl(),
        random: sl(),
        inputConverter: sl(),
      ));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteNumberTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomNumberTrivia(sl()));

  // Repository
  sl.registerLazySingleton<NumberTriviaRepository>(
          () =>
          NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  // Data Sources
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(() =>
      NumberTriviaRemoteDataSourceImpl(httpClient: sl(),));
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImpl(preferences: sl(),));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharePreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharePreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => DataConnectionChecker());
}

void initFeatures() {}

void initCore() {}

void initExternal() {}
