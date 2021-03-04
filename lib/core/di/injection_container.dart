import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_local_data_source.dart';
import 'package:search_gold_quotes/app/data/datasources/home_data_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/datasources/version_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/datasources/video_remote_data_source.dart';
import 'package:search_gold_quotes/app/data/repositories/home_repository_impl.dart';
import 'package:search_gold_quotes/app/data/repositories/version_repository_impl.dart';
import 'package:search_gold_quotes/app/data/repositories/video_repository_impl.dart';
import 'package:search_gold_quotes/app/domain/repositories/home_repository.dart';
import 'package:search_gold_quotes/app/domain/repositories/version_repository.dart';
import 'package:search_gold_quotes/app/domain/repositories/video_repository.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_home_data.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_version_info.dart';
import 'package:search_gold_quotes/app/domain/usecases/get_video_list.dart';
import 'package:search_gold_quotes/app/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:search_gold_quotes/app/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:search_gold_quotes/app/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:search_gold_quotes/app/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:search_gold_quotes/app/number_trivia/presentation/number_trivia/number_trivia_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/intro/bloc/bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/home/home/home_bloc.dart';
import 'package:search_gold_quotes/app/presentation/pages/main/video/video/video_bloc.dart';
import 'package:search_gold_quotes/core/platform/network_info.dart';
import 'package:search_gold_quotes/core/presentation/utils/input_converter.dart';
import 'package:search_gold_quotes/core/theme/theme_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Service Locator
final container = GetIt.instance;

Future<void> init() async {
  //! Features - VersionInfo

  // Bloc
  container.registerFactory(() =>
    SplashBloc(versionInfo: container())
  );

  container.registerFactory(() =>
    HomeBloc(homeInfo: container())
  );

  container.registerFactory(() =>
      VideoBloc(videoListUsecase: container())
  );

  // Use cases
  container.registerLazySingleton(() => GetVersionInfo(repository: container()));
  container.registerLazySingleton(() => GetHomeInfo(homeRepository: container()));
  container.registerLazySingleton(() => GetVideoList(repository: container()));

  // Repository
  container.registerLazySingleton<VersionRepository>(() =>
    VersionRepositoryImpl(remoteDataSource: container(), networkInfo: container())
  );
  container.registerLazySingleton<HomeRepository>(() =>
      HomeRepositoryImpl(remoteDataSource: container(), networkInfo: container())
  );
  container.registerLazySingleton<VideoRepository>(() =>
      VideoRepositoryImpl(dataSource: container(), networkInfo: container())
  );

  // DataSource
  container.registerLazySingleton<VersionRemoteDataSource>(() =>
      VersionRemoteDataSourceImpl(httpClient: container())
  );
  container.registerLazySingleton<HomeDataRemoteDataSource>(() =>
      HomeDataRemoteDataSourceImpl(httpClient: container())
  );
  container.registerLazySingleton<HomeDataLocalDataSource>(() =>
    HomeDataLocalDataSourceImpl(sharedPreferences: container())
  );
  container.registerLazySingleton<VideoRemoteDataSource>(() =>
      VideoRemoteDataSourceImpl(httpClient: container())
  );

  //! Featurs - NumberTrivia

  // Bloc
  container.registerFactory(() =>
      NumberTriviaBloc(
        concrete: container(),
        random: container(),
        inputConverter: container(),
      ));

  // Use cases
  container.registerLazySingleton(() => GetConcreteNumberTrivia(container()));
  container.registerLazySingleton(() => GetRandomNumberTrivia(container()));

  // Repository
  container.registerLazySingleton<NumberTriviaRepository>(
          () =>
          NumberTriviaRepositoryImpl(
            remoteDataSource: container(),
            localDataSource: container(),
            networkInfo: container(),
          ));

  // Data Sources
  container.registerLazySingleton<NumberTriviaRemoteDataSource>(() =>
      NumberTriviaRemoteDataSourceImpl(httpClient: container(),));
  container.registerLazySingleton<NumberTriviaLocalDataSource>(() =>
      NumberTriviaLocalDataSourceImpl(preferences: container(),));


  //! External
  final sharePreferences = await SharedPreferences.getInstance();
  container.registerLazySingleton(() => sharePreferences);
  container.registerLazySingleton(() => Dio());
  container.registerLazySingleton(() => Connectivity());


  //! Core
  container.registerLazySingleton(() => InputConverter());
  container.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(container()));
  container.registerLazySingleton(() => ThemeNotifier(preferences: container()));

}

void initFeatures() {}

void initCore() {}

void initExternal() {}
