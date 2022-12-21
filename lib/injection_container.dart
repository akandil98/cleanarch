import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:cleanarch/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:cleanarch/features/random_quote/data/repositories/quote_repository_impl.dart';
import 'package:cleanarch/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:cleanarch/features/random_quote/domain/usecases/get_random_quote.dart';
import 'package:cleanarch/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  // features
  //blocs
  sl.registerFactory<RandomQuoteCubit>(
      () => RandomQuoteCubit(getRandomQuoteUseCase: sl()));

  //use cases
  sl.registerLazySingleton<GetRandomQuote>(
      () => GetRandomQuote(quoteRepository: sl()));

  //repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
        netWorkInfo: sl(),
        randomQuoteRemoteDataSource: sl(),
        randomQuoteLocalDataSource: sl(),
      ));

  // Data Source
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
      () => RandomQuoteLocalDataSourceImp(sharedPreferences: sl()));

  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
      () => RandomQuoteRemoteDataSourceImpl(client: sl()));
  // core
  sl.registerLazySingleton<NetWorkInfo>(
      () => NetworkInfoImpl(connectionChecker: sl()));

  // external
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
