import 'package:cleanarch/core/error/exceptions.dart';
import 'package:cleanarch/core/network/network_info.dart';
import 'package:cleanarch/features/random_quote/data/datasources/random_quote_local_data_source.dart';
import 'package:cleanarch/features/random_quote/data/datasources/random_quote_remote_data_source.dart';
import 'package:cleanarch/features/random_quote/domain/entities/quote.dart';
import 'package:cleanarch/core/error/failures.dart';
import 'package:cleanarch/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:dartz/dartz.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetWorkInfo netWorkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

  QuoteRepositoryImpl({
    required this.netWorkInfo,
    required this.randomQuoteRemoteDataSource,
    required this.randomQuoteLocalDataSource,
  });
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await netWorkInfo.isConnected) {
      try {
        final remoteRandomQuote =
            await randomQuoteRemoteDataSource.getRandomQuote();
        //Caching remoteRandomQuote when network is connected
        randomQuoteLocalDataSource.cacheQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final cacheRandomQuote =
            await randomQuoteLocalDataSource.getLastRandomQuote();
        return Right(cacheRandomQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }

    /*
      if(is connected)
      {
        get data from api
      }else{
        get data from cache
      }
     */
  }
}
