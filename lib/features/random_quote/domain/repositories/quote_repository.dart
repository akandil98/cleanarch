import 'package:cleanarch/core/error/failures.dart';
import 'package:cleanarch/features/random_quote/domain/entities/quote.dart';
import 'package:dartz/dartz.dart';

abstract class QuoteRepository {
  Future<Either<Failure, Quote>> getRandomQuote();
}
